;;; chasen.el --- chasen library

;; Copyright (C) 2003 Susumu Ota

;; Author: Susumu ota <ccbcc@black.livedoor.com>
;; Keywords: Japanese, tokenizer

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.

;; You should have received a copy of the GNU General Public
;; License along with this program; if not, write to the Free
;; Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
;; MA 02111-1307 USA


;; Usage:
;;   Asynchronous process version
;;     (chasen-async-open)
;;     (chasen-async-tokenize-string "Japanese string")
;;     (chasen-async-string-for-each #'print "Japanese string")
;;     (chasen-async-close)
;;
;;   Synchronous process version
;;     (chasen-sync-tokenize-string "Japanese string")
;;     (chasen-sync-string-for-each #'print "Japanese string")


;;; Code:

(eval-when-compile
  (require 'cl))


;;;
;;; constant
;;;
(defconst chasen-cvs-id "$Id: chasen.el,v 1.10 2003/11/05 14:13:46 ota Exp $")


;;;
;;; default value
;;;
(defvar chasen-program "chasen"
  "Default chasen program name.")

(defvar chasen-run-options '("-j" "-F%m\\n")
  "Default chasen run option, see chasen manual.")

(defvar chasen-decoding 'iso-2022-7bit-unix
  "Default decodeing.")

(defvar chasen-encoding 'iso-2022-7bit-unix
  "Default encodeing.")

(defvar chasen-process-decoding 'euc-japan-unix
  "Default process decodeing.")

(defvar chasen-process-encoding 'euc-japan-unix
  "Default process encodeing.")

(defvar chasen-receive-timeout-second 1
  "Default receive timeout (second).")

(defvar chasen-receive-timeout-microsecond 0
  "Default receive timeout (microsecond).")

(defvar chasen-process nil
  "Default chasen process object.")

(defvar chasen-process-send-string-limit (* 1024 2)
  "非同期プロセスで処理するテキスト容量の閾値.
Meadow-1.10 で非同期プロセスで通信すると, 容量の大きいテキストを
`process-send-string' するとフリーズしてしまうので, この容量より
大きいテキストはファイルに落としてから, 同期プロセスで実行する.")


(defvar chasen-debug-p nil
  "Debug or not.")


;;;
;;; utility
;;;
(defmacro chasen-optional-bind (var-vals &rest body)
  "Set default value to &optional variable.

in Common Lisp:
\(defun func (&optional (foo 1) (bar 2))
  (print foo)
  (print bar))

in Emacs Lisp:
\(defun func (&optional foo bar)
  (chasen-optional-bind ((foo 1) (bar 2))
    (print foo)
    (print bar)))

macroexpand result is:
\(macroexpand '(chasen-optional-bind ((foo 1) (bar 2))
                (print foo)
                (print bar)))
==>
\(let ((foo (or foo 1))
      (bar (or bar 2)))
  (print foo)
  (print bar))"
  `(let (,@(mapcar #'(lambda (var-val)
		       `(,(car var-val) (or ,(car var-val) ,(cadr var-val))))
	    var-vals))
     ,@body))

(defmacro chasen-default-bind (vars &rest body)
  "Set chasen default variable to &optional variable.
see `chasen-optional-bind'

macroexpand result is:
\(macroexpand '(chasen-default-bind (foo bar)
                (print foo)
                (print bar)))
==>
\(let ((foo (or foo chasen-foo))
      (bar (or bar chasen-bar)))
  (print foo)
  (print bar))"
  `(chasen-optional-bind
     (,@(mapcar #'(lambda (var)
	 	   `(,var ,(intern (concat "chasen-" (symbol-name var)))))
	       vars))
     ,@body))

(defun split-string-for-each (split-string-for-each-function
			      string
			      &optional separators)
  "Splits STRING into substrings where there are matches for SEPARATORS.
see `split-string' (subr.el)"
  (let ((rexp (or separators "[ \f\t\n\r\v]+"))
	(start 0)
	(len (length string))
	notfirst
	begin
	end)
    (while (and (string-match rexp string
			      (if (and notfirst
				       (= start begin)
				       (< start len))
				  (1+ start) start))
		(progn (setq begin (match-beginning 0)) ; save value
		       (setq end (match-end 0))
		       t)
		(< begin len))
      (setq notfirst t)
      (or (eq begin 0)
	  (and (eq begin end)
	       (eq begin start))
	  (funcall split-string-for-each-function
		   (substring string start begin)))
      (setq start end))
    (or (eq start len)
	(funcall split-string-for-each-function
		 (substring string start)))
    nil))

(defun chasen-message (&rest args)
  (when chasen-debug-p
    (apply #'message args)))

(defun chasen-make-temp-file (filename)
  (if (fboundp 'make-temp-file)
      (make-temp-file filename)
    (make-temp-name filename)))

(defun chasen-for-each-to-list (chasen-for-each-to-list-function &rest args)
  (let ((result nil))
    (apply chasen-for-each-to-list-function
	   #'(lambda (item) (push item result))
	   args)
    (nreverse result)))


;;;
;;; Asynchronous process version
;;;
(defvar chasen-receive-queue (make-hash-table :test #'equal)
  "Queue for receive message.")

(defun chasen-push-receive-queue (process string)
  "Accessor for `chasen-receive-queue'."
  ;; TODO: inline?
  ;; TODO: erase push
  (push string (gethash (process-name process) chasen-receive-queue)))

(defun chasen-get-receive-queue (process)
  "Accessor for `chasen-receive-queue'."
  ;; TODO: inline?
  (gethash (process-name process) chasen-receive-queue))

(defun chasen-clear-receive-queue (process)
  "Accessor for `chasen-receive-queue'."
  ;; TODO: inline?
  ;; TODO: erase setf
  (setf (gethash (process-name process) chasen-receive-queue) nil))

(defun chasen-flush-receive-queue (process)
  "Accessor for `chasen-receive-queue'."
  ;; TODO: inline?
  (let ((queue (chasen-get-receive-queue process)))
    (when queue
      (prog1 (apply #'concat (nreverse queue))
	(chasen-clear-receive-queue process)))))

(defun chasen-async-filter (process string)
  "Filter function for chasen process."
  (chasen-push-receive-queue process string))

(defun chasen-async-open (&optional program process-decoding process-encoding
			  &rest run-options)
  "Open chasen process."
  (chasen-default-bind (program process-decoding process-encoding run-options)
    (let ((process (apply #'start-process "chasen" nil program run-options)))
      (set-process-coding-system process process-decoding process-encoding)
      (set-process-filter process #'chasen-async-filter)
      (setq chasen-process process))))

(defun chasen-async-close (&optional process)
  "Close chasen process."
  (chasen-default-bind (process)
    (when process
      (unwind-protect
	  (progn
	    (process-send-eof process)
	    t)
	(progn
	  (chasen-clear-receive-queue process)
	  (delete-process process)
	  (when (eq process chasen-process)
	    (setq chasen-process nil)))))))

(defun chasen-async-send (process string)
  "Send message to chasen process."
  ;; TODO: inline?
  (process-send-string process string)
  (when (member "-j" chasen-run-options)
    (process-send-string process "\n。\n")))

(defun chasen-async-receive (process
			     receive-timeout-second
			     receive-timeout-microsecond)
  "Receive message from chasen process."
  ;; TODO: inline?
  ;; Meadow-1.10 (Emacs 20.4.1, Windows-2000) ignore microsecond argument
  (while (accept-process-output process
				receive-timeout-second
				receive-timeout-microsecond))
  (chasen-flush-receive-queue process))

(defun chasen-async-string-for-each (chasen-async-string-for-each-function
				     string
				     &optional process
				               receive-timeout-second
					       receive-timeout-microsecond)
  "Tokenize Japanese string (string, for-each)."
  (chasen-default-bind (process
			receive-timeout-second
			receive-timeout-microsecond)
    (chasen-message "chasen: sending...")
    (chasen-async-send process string)
    (chasen-message "chasen: sending...reveiving...")
    (let ((response (chasen-async-receive process
					  receive-timeout-second
					  receive-timeout-microsecond)))
      (when response
	(chasen-message "chasen: sending...reveiving...splitting...")
	(split-string-for-each
	 #'(lambda (line)
	     (unless (or (equal "EOS" line) (equal "" line))
	       (funcall chasen-async-string-for-each-function line)))
	 response
	 "\n"))
      (chasen-message "chasen: sending...reveiving...splitting...done")
      nil)))

(defun chasen-async-buffer-for-each (chasen-async-buffer-for-each-function
				     buffer
				     &optional process
				               receive-timeout-second
					       receive-timeout-microsecond)
  "Tokenize Japanese string (buffer, for-each)."
  (with-current-buffer buffer
    (widen);; OK?
    (chasen-async-string-for-each chasen-async-buffer-for-each-function
				  (buffer-substring-no-properties
				   (point-min) (point-max))
				  process
				  receive-timeout-second
				  receive-timeout-microsecond)))

(defun chasen-async-file-for-each (chasen-async-file-for-each-function
				   in-filename
				   &optional process
				             receive-timeout-second
					     receive-timeout-microsecond)
  "Tokenize Japanese string (file, for-each)."
  (with-temp-buffer
    (insert-file-contents in-filename)
    (chasen-async-buffer-for-each chasen-async-file-for-each-function
				  (current-buffer)
				  process
				  receive-timeout-second
				  receive-timeout-microsecond)))

(defun chasen-async-tokenize-string (string
				     &optional process
				               receive-timeout-second
					       receive-timeout-microsecond)
  "Tokenize Japanese string (string, list)."
  (chasen-for-each-to-list #'chasen-async-string-for-each
			   string
			   process
			   receive-timeout-second
			   receive-timeout-microsecond))

(defun chasen-async-tokenize-buffer (buffer
				     &optional process
				               receive-timeout-second
					       receive-timeout-microsecond)
  "Tokenize Japanese string (buffer, list)."
  (chasen-for-each-to-list #'chasen-async-buffer-for-each
			   buffer
			   process
			   receive-timeout-second
			   receive-timeout-microsecond))

(defun chasen-async-tokenize-file (in-filename
				   &optional process
				             receive-timeout-second
					     receive-timeout-microsecond)
  "Tokenize Japanese string (file, list)."
  (chasen-for-each-to-list #'chasen-async-file-for-each
			   in-filename
			   process
			   receive-timeout-second
			   receive-timeout-microsecond))


;;;
;;; Synchronous process version
;;;
(defun chasen-execute-program (in-filename out-filename
			       &optional program run-options)
  "Execute chasen command."
  (chasen-default-bind (program run-options)
    (apply #'call-process program nil nil nil
	   `(,@run-options
	     "-o" ,(expand-file-name out-filename)
	     ,(expand-file-name in-filename)))))

(defun chasen-write-file (string out-filename &optional encoding)
  "Write string to file."
  (chasen-default-bind (encoding)
    (with-temp-file out-filename
      (set-buffer-file-coding-system encoding)
      (insert string))))

(defun chasen-read-file (in-filename &optional decoding)
  "Read string from file."
  (chasen-default-bind (decoding)
    (with-temp-buffer
      (set-buffer-file-coding-system decoding)
      (insert-file-contents in-filename)
      (buffer-substring-no-properties (point-min) (point-max)))))

(defun chasen-sync-file-for-each (chasen-sync-file-for-each-function
				  in-filename
				  &optional program decoding encoding
				  &rest run-options)
  "Tokenize Japanese string (file, for-each)."
  (chasen-default-bind (program decoding run-options)
    (let ((out-filename (concat in-filename ".cha")))
      (unwind-protect
	  (progn
	    (chasen-message "chasen: %s executing..." in-filename)
	    (chasen-execute-program in-filename out-filename
				    program run-options)
	    (chasen-message "chasen: %s executing...reading..." in-filename)
	    (let ((string (chasen-read-file out-filename decoding)))
	      (chasen-message "chasen: %s executing...reading...splitting..."
			      in-filename)
	      (when string
		(split-string-for-each
		 #'(lambda (line)
		     (unless (or (equal "EOS" line) (equal "" line))
		       (funcall chasen-sync-file-for-each-function line)))
		 string
		 "\n"))
	      (chasen-message
	       "chasen: %s executing...reading...splitting...done"
	       in-filename)
	      nil))
	(delete-file out-filename)))))

(defun chasen-sync-buffer-for-each (chasen-sync-buffer-for-each-function
				    buffer
				    &optional program decoding encoding
				    &rest run-options)
  "Tokenize Japanese string (string, for-each)."
  (chasen-default-bind (encoding)
    (let ((tmp-filename (chasen-make-temp-file "chasen-tmp-")))
      (unwind-protect
	  (progn
	    (with-current-buffer buffer
	      (set-buffer-file-coding-system encoding)
	      (widen);; OK?
	      (write-region (point-min) (point-max) tmp-filename nil 0))
	    (apply #'chasen-sync-file-for-each
		   chasen-sync-buffer-for-each-function
		   tmp-filename
		   program decoding encoding run-options))
	(delete-file tmp-filename)))))

(defun chasen-sync-string-for-each (chasen-sync-string-for-each-function
				    string
				    &optional program decoding encoding
				    &rest run-options)
  "Tokenize Japanese string (string, for-each)."
  (with-temp-buffer
    (insert string)
    (apply #'chasen-sync-buffer-for-each
	   chasen-sync-string-for-each-function
	   (current-buffer)
	   program decoding encoding run-options)))

(defun chasen-sync-tokenize-file (in-filename
				  &optional program decoding encoding
				  &rest run-options)
  "Tokenize Japanese string (file, list)."
  (chasen-for-each-to-list #'chasen-sync-file-for-each
			   in-filename program decoding encoding run-options))

(defun chasen-sync-tokenize-buffer (buffer
				    &optional program decoding encoding
				    &rest run-options)
  "Tokenize Japanese string (buffer, list)."
  (chasen-for-each-to-list #'chasen-sync-buffer-for-each
			   buffer program decoding encoding run-options))

(defun chasen-sync-tokenize-string (string
				    &optional program decoding encoding
				    &rest run-options)
  "Tokenize Japanese string (string, list)."
  (chasen-for-each-to-list #'chasen-sync-string-for-each
			   string program decoding encoding run-options))

;;;
;;; Combined(?) version
;;;
(defun chasen-file-for-each (chasen-file-for-each-function in-filename)
  (chasen-sync-file-for-each chasen-file-for-each-function in-filename))

(defun chasen-buffer-for-each (chasen-buffer-for-each-function buffer)
  (let ((len (with-current-buffer buffer (buffer-size))))
    (if (< chasen-process-send-string-limit len)
	(chasen-sync-buffer-for-each chasen-buffer-for-each-function buffer)
      (chasen-async-buffer-for-each chasen-buffer-for-each-function buffer))))

(defun chasen-string-for-each (chasen-string-for-each-function string)
  (let ((len (length string)))
    (if (< chasen-process-send-string-limit len)
	(chasen-sync-string-for-each chasen-string-for-each-function string)
      (chasen-async-string-for-each chasen-string-for-each-function string))))

(defun chasen-tokenize-file (in-filename)
  (chasen-sync-tokenize-file in-filename))

(defun chasen-tokenize-buffer (buffer)
  (let ((len (with-current-buffer buffer (buffer-size))))
    (if (< chasen-process-send-string-limit len)
	(chasen-sync-tokenize-buffer buffer)
      (chasen-async-tokenize-buffer buffer))))

(defun chasen-tokenize-string (string)
  (let ((len (length string)))
    (if (< chasen-process-send-string-limit len)
	(chasen-sync-tokenize-string string)
      (chasen-async-tokenize-string string))))


(provide 'chasen)

;;; chasen.el ends here
