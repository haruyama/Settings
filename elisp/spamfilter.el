;;; spamfilter.el --- spam filter

;; Copyright (C) 2003 Susumu Ota

;; Author: Susumu ota <ccbcc@black.livedoor.com>
;; Keywords: SPAM, filter

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
;;   register words
;;     (spamf-register-words-directory spamf-good-corpus "~/Mail/inbox")
;;     (spamf-register-words-directory spamf-bad-corpus "~/Mail/spam")
;;   or
;;     (spamf-register-words-file spamf-good-corpus "~/Mail/inbox/1")
;;     (spamf-register-words-file spamf-bad-corpus "~/Mail/spam/1")
;;   or
;;     (spamf-register-words-buffer spamf-good-corpus (current-buffer))
;;     (spamf-register-words-buffer spamf-bad-corpus (current-buffer))
;;   or
;;     (spamf-register-words-string spamf-good-corpus "Japanese string")
;;     (spamf-register-words-string spamf-bad-corpus "Japanese string")
;;
;;   delete words
;;     (spamf-delete-words-directory spamf-good-corpus "~/Mail/inbox")
;;     (spamf-delete-words-directory spamf-bad-corpus "~/Mail/spam")
;;   or
;;     (spamf-delete-words-file spamf-good-corpus "~/Mail/inbox/1")
;;     (spamf-delete-words-file spamf-bad-corpus "~/Mail/spam/1")
;;   or
;;     (spamf-delete-words-buffer spamf-good-corpus (current-buffer))
;;     (spamf-delete-words-buffer spamf-bad-corpus (current-buffer))
;;   or
;;     (spamf-delete-words-string spamf-good-corpus "Japanese string")
;;     (spamf-delete-words-string spamf-bad-corpus "Japanese string")
;;
;;   judge spam
;;     (spamf-spam-file-p "~/Mail/unknown/1")
;;     (spamf-spam-buffer-p (current-buffer))
;;     (spamf-spam-string-p "Japanese string")


;;; Code:

(if (and (fboundp 'make-hash-table) (subrp (symbol-function 'make-hash-table)))
    (eval-when-compile (require 'cl)) ; hash functions are built-in function.
  (require 'cl)) ; hash functions are provided by cl package.

(require 'chasen)
(require 'japanese-tokenizer)


;;;
;;; constant
;;;
(defconst spamf-cvs-id "$Id: spamfilter.el,v 1.13 2004/01/22 07:36:57 ota Exp $")


;;;
;;; parameter
;;;
; (defvar spamf-file-for-each-function   #'chasen-sync-file-for-each)
; (defvar spamf-buffer-for-each-function #'chasen-sync-buffer-for-each)
; (defvar spamf-string-for-each-function #'chasen-sync-string-for-each)
; (defvar spamf-tokenize-file-function   #'chasen-sync-tokenize-file)
; (defvar spamf-tokenize-buffer-function #'chasen-sync-tokenize-buffer)
; (defvar spamf-tokenize-string-function #'chasen-sync-tokenize-string)

; (defvar spamf-file-for-each-function   #'chasen-async-file-for-each)
; (defvar spamf-buffer-for-each-function #'chasen-async-buffer-for-each)
; (defvar spamf-string-for-each-function #'chasen-async-string-for-each)
; (defvar spamf-tokenize-file-function   #'chasen-async-tokenize-file)
; (defvar spamf-tokenize-buffer-function #'chasen-async-tokenize-buffer)
; (defvar spamf-tokenize-string-function #'chasen-async-tokenize-string)

; (defvar spamf-file-for-each-function   #'chasen-file-for-each)
; (defvar spamf-buffer-for-each-function #'chasen-buffer-for-each)
; (defvar spamf-string-for-each-function #'chasen-string-for-each)
; (defvar spamf-tokenize-file-function   #'chasen-tokenize-file)
; (defvar spamf-tokenize-buffer-function #'chasen-tokenize-buffer)
; (defvar spamf-tokenize-string-function #'chasen-tokenize-string)

; (defvar spamf-file-for-each-function   #'jtoken-block-file-for-each)
; (defvar spamf-buffer-for-each-function #'jtoken-block-buffer-for-each)
; (defvar spamf-string-for-each-function #'jtoken-block-string-for-each)
; (defvar spamf-tokenize-file-function   #'jtoken-block-tokenize-file)
; (defvar spamf-tokenize-buffer-function #'jtoken-block-tokenize-buffer)
; (defvar spamf-tokenize-string-function #'jtoken-block-tokenize-string)

(defvar spamf-file-for-each-function   #'jtoken-bigram-file-for-each)
(defvar spamf-buffer-for-each-function #'jtoken-bigram-buffer-for-each)
(defvar spamf-string-for-each-function #'jtoken-bigram-string-for-each)
(defvar spamf-tokenize-file-function   #'jtoken-bigram-tokenize-file)
(defvar spamf-tokenize-buffer-function #'jtoken-bigram-tokenize-buffer)
(defvar spamf-tokenize-string-function #'jtoken-bigram-tokenize-string)


(defvar spamf-corpus-filename "~/.spamfilter"
  "Default corpus filename.
デフォルトのコーパスファイル名.")

(defvar spamf-encoding 'iso-2022-7bit-unix
  "Default encoding.
コーパスファイルに保存する時のエンコーディング.")

(defvar spamf-cutoff-words-limit 15
  "Cut off words limit.
ベイズ確率の計算対象とする単語数.")

(defvar spamf-min-probability 0.001
  "Minimum spam probability.
片方のコーパスにのみ単語が見つかった場合に採用する確率.")

(defvar spamf-spamness-limit 0.9
  "Spamness limit.
スパムと判定する閾値.")

(defvar spamf-debug-p t
  "Debug mode or not.")

(defvar spamf-obarray-length 65537
  "Obarray length.
obarray のデフォルトの長さ. 適当な大きさの素数.")
 
(defvar spamf-obarray (make-vector spamf-obarray-length 0)
  "Obarray for spamfilter corpus.
`intern' するときに使う obarray. デフォルトの `obarray' を使うと, 他のパッケージの動作が遅くなってしまうので.") 

;;;
;;; utility
;;;
(defsubst spamf-puthash (key value hash)
  "Wrapper for `puthash'.
実行時に cl に依存するのを避けるため.
\(macroexpand '(setf (gethash key hash) value)) => (cl-puthash key value hash)
となる環境があるので."
  (if (fboundp 'puthash)
      (puthash key value hash)
    (setf (gethash key hash) value)))

(defun spamf-hash-to-alist (hash)
  "Convert hash-table to alist.
see `spamf-alist-to-hash'."
  ;; TODO: inline?
  (let ((r nil))
    (maphash #'(lambda (key value) (push (cons key value) r)) hash)
    r))

(defun spamf-alist-to-hash (alist hash)
  "Convert alist to hash-table.
see `spamf-hash-to-alist'."
  ;; TODO: inline?
  (dolist (key-value alist)
    (spamf-puthash (car key-value) (cdr key-value) hash))
  hash)

(defun spamf-head (lst &optional n)
  "Return head of list.
LST の先頭から N 個のリストを返す.
\(spamf-head '(a b c d e) 2) => (a b)
This is equivalent to `(butlast LST (- (length LST) (or N 1)))'."
  ;; TODO: inline?
  (if (null n) (cons (car lst) nil)
    (do ((lst lst (cdr lst))
	 (i 0 (1+ i))
	 (r nil (cons (car lst) r)))
	((or (null lst) (<= n i))
	 (nreverse r)))))

(defun spamf-directory-for-each (spamf-directory-for-each-function dirname)
  "DIRNAME 内のファイルに再帰的に SPAMF-DIRECTORY-FOR-EACH-FUNCTION を適用する.
\(spamf-directory-for-each #'print \"/tmp\")
注意: ディレクトリ階層が深いとスタックオーバーフローする."
  (let ((abs-filename (expand-file-name dirname)))
    (cond ((file-accessible-directory-p abs-filename)
	   (dolist (file (directory-files abs-filename))
	     (unless (or (equal "." file) (equal ".." file))
	       (spamf-directory-for-each spamf-directory-for-each-function
					 (concat abs-filename "/" file)))))
	  ((file-readable-p abs-filename)
	   (funcall spamf-directory-for-each-function abs-filename))
	  (t nil))))

(defun spamf-buffer-string (&optional start end)
  "Wrapper for `buffer-substring-no-properties'."
  ;; TODO: inline?
  (buffer-substring-no-properties (or start (point-min)) (or end (point-max))))

(defun spamf-message (&rest args)
  "Wrapper for `message'."
  ;; TODO: inline?
  (when spamf-debug-p
    (apply #'message args)))

(defsubst spamf-intern (string)
  "Wrapper for `intern'."
  (intern string spamf-obarray))


;;;
;;; spam(bad)/nospam(good) words corpus
;;;
(defstruct spamf-corpus name table message-count)

(defvar spamf-good-corpus
  (make-spamf-corpus :name "spamf-good-corpus"
		     :table (make-hash-table :test #'eq)
		     :message-count 0))

(defvar spamf-bad-corpus
  (make-spamf-corpus :name "spamf-bad-corpus"
		     :table (make-hash-table :test #'eq)
		     :message-count 0))

(defmacro with-spamf-corpus (good-corpus bad-corpus &rest body)
  "optional 引数でコーパスをいちいち指定するのが面倒な人用."
  ;; (declare (indent 2) (debug t))
  `(let ((spamf-good-corpus ,good-corpus)
	 (spamf-bad-corpus ,bad-corpus))
     ,@body))

(defun spamf-set-corpus (corpus message-count alist)
  (when (zerop (spamf-corpus-message-count corpus))
    (clrhash (spamf-corpus-table corpus))
    (setf (spamf-corpus-message-count corpus) message-count)
    (dolist (key-value alist)
      (spamf-puthash (spamf-intern (car key-value))
		     (cdr key-value)
		     (spamf-corpus-table corpus)))))

(defun spamf-insert-corpus-string (corpus)
  (let ((name (spamf-corpus-name corpus))
	(table (spamf-corpus-table corpus))
	(message-count (spamf-corpus-message-count corpus)))
    (insert (format "(spamf-set-corpus %s %s '(\n" name message-count))
    (if spamf-debug-p
	(dolist (key-value (sort (spamf-hash-to-alist table)
				 #'(lambda (x y) (> (cdr x) (cdr y)))))
	  (insert (format "(%S . %S)\n"
			  (symbol-name (car key-value)) (cdr key-value))))
      (maphash #'(lambda (key value)
		   (insert (format "(%S . %S)\n" (symbol-name key) value)))
	       table))
    (insert "))\n\n")))

(defun spamf-save-corpus-to-file (filename &optional good-corpus bad-corpus)
  (let ((good-corpus (or good-corpus spamf-good-corpus))
	(bad-corpus (or bad-corpus spamf-bad-corpus)))
    (when (file-exists-p filename)
      (rename-file filename (concat filename ".bak") t))
    (with-temp-file filename
      (set-buffer-file-coding-system spamf-encoding)
      (spamf-insert-corpus-string good-corpus)
      (spamf-insert-corpus-string bad-corpus))))

(defun spamf-load-corpus-from-file (filename)
  (when (file-readable-p filename)
    (load filename)))

(defsubst spamf-increase-word-count (corpus word)
  (let* ((table (spamf-corpus-table corpus))
	 (count (or (gethash word table) 0)))
    (spamf-puthash word (1+ count) table)))

(defsubst spamf-decrease-word-count (corpus word)
  (let* ((table (spamf-corpus-table corpus))
	 (count (gethash word table)))
    (when count
      (if (<= count 1) (remhash word table)
	(spamf-puthash word (1- count) table)))))

(defsubst spamf-get-word-count (corpus word)
  (or (gethash word (spamf-corpus-table corpus)) 0))

(defun spamf-register-words-file (corpus filename)
  (funcall spamf-file-for-each-function
	   #'(lambda (token)
	       (spamf-increase-word-count corpus (spamf-intern token)))
	   filename)
  (incf (spamf-corpus-message-count corpus)))

(defun spamf-register-words-buffer (corpus buffer)
  (funcall spamf-buffer-for-each-function
	   #'(lambda (token)
	       (spamf-increase-word-count corpus (spamf-intern token)))
	   buffer)
  (incf (spamf-corpus-message-count corpus)))

(defun spamf-register-words-string (corpus string)
  (funcall spamf-string-for-each-function
	   #'(lambda (token)
	       (spamf-increase-word-count corpus (spamf-intern token)))
	   string)
  (incf (spamf-corpus-message-count corpus)))

(defun spamf-register-words-directory (corpus dirname)
  (spamf-directory-for-each #'(lambda (filename)
				(spamf-register-words-file corpus filename))
			    dirname))

(defun spamf-delete-words-file (corpus filename)
  (funcall spamf-file-for-each-function
	   #'(lambda (token)
	       (spamf-decrease-word-count corpus (spamf-intern token)))
	   filename)
  (if (<= (spamf-corpus-message-count corpus) 0)
      (setf (spamf-corpus-message-count corpus) 0)
    (decf (spamf-corpus-message-count corpus))))

(defun spamf-delete-words-buffer (corpus buffer)
  (funcall spamf-buffer-for-each-function
	   #'(lambda (token)
	       (spamf-decrease-word-count corpus (spamf-intern token)))
	   buffer)
  (if (<= (spamf-corpus-message-count corpus) 0)
      (setf (spamf-corpus-message-count corpus) 0)
    (decf (spamf-corpus-message-count corpus))))

(defun spamf-delete-words-string (corpus string)
  (funcall spamf-string-for-each-function
	   #'(lambda (token)
	       (spamf-decrease-word-count corpus (spamf-intern token)))
	   string)
  (if (<= (spamf-corpus-message-count corpus) 0)
      (setf (spamf-corpus-message-count corpus) 0)
    (decf (spamf-corpus-message-count corpus))))

(defun spamf-delete-words-directory (corpus dirname)
  (spamf-directory-for-each #'(lambda (filename)
				(spamf-delete-words-file corpus filename))
			    dirname))

(defun spamf-calculate-spam-probability (word &optional good-corpus bad-corpus)
  "Calculate word's SPAM probability.
See http://www.paulgraham.com/spam.html
See http://www.paulgraham.com/better.html"
  (let ((good-corpus (or good-corpus spamf-good-corpus))
	(bad-corpus (or bad-corpus spamf-bad-corpus)))
    (let ((g (spamf-get-word-count good-corpus word))
	  (b (spamf-get-word-count bad-corpus word))
	  (ngood (spamf-corpus-message-count good-corpus))
	  (nbad (spamf-corpus-message-count bad-corpus)))
      (cond ((< (+ (* g 2) b) 5)
	     0.4)
	    ((zerop g)
	     (if (> b 10) (- 1.0 spamf-min-probability)
	       (- 1.0 (* 2.0 spamf-min-probability))))
	    ((zerop b)
	     (if (> g 10) spamf-min-probability
	       (* 2.0 spamf-min-probability)))
	    (t (let ((g (float g))
		     (b (float b))
		     (ngood (float ngood))
		     (nbad (float nbad)))
		 (/ (/ b nbad) (+ (/ (* g 2.0) ngood) (/ b nbad)))))))))

(defun spamf-sum-spam-probability (probs)
  "Calculate Bayesian probability.
See http://www.paulgraham.com/spam.html
See http://www.paulgraham.com/better.html"
  (let ((px (float (apply #'* probs)))
	(qy (float (apply #'* (mapcar #'(lambda (p) (- 1 p)) probs)))))
    (/ px (+ px qy))))

(defun spamf-cutoff-words (words n &optional good-corpus bad-corpus)
  (let ((prob-table (make-hash-table :test #'eq)))
    (dolist (word words)
      (let ((word (spamf-intern word)))
	(unless (gethash word prob-table)
	  (spamf-puthash word
			 (spamf-calculate-spam-probability word
							   good-corpus
							   bad-corpus)
			 prob-table))))
    (spamf-head (sort (spamf-hash-to-alist prob-table)
		      #'(lambda (x y) (> (abs (- 0.5 (cdr x)))
					 (abs (- 0.5 (cdr y))))))
		n)))

(defun spamf-calculate-spamness-file (filename &optional good-corpus bad-corpus)
  (let ((words (spamf-cutoff-words
		(funcall spamf-tokenize-file-function filename)
		spamf-cutoff-words-limit
		good-corpus bad-corpus)))
    (list (spamf-sum-spam-probability (mapcar #'cdr words)) words)))

(defun spamf-calculate-spamness-buffer (buffer &optional good-corpus bad-corpus)
  (let ((words (spamf-cutoff-words
		(funcall spamf-tokenize-buffer-function buffer)
		spamf-cutoff-words-limit
		good-corpus bad-corpus)))
    (list (spamf-sum-spam-probability (mapcar #'cdr words)) words)))

(defun spamf-calculate-spamness-string (string &optional good-corpus bad-corpus)
  (let ((words (spamf-cutoff-words
		(funcall spamf-tokenize-string-function string)
		spamf-cutoff-words-limit
		good-corpus bad-corpus)))
    (list (spamf-sum-spam-probability (mapcar #'cdr words)) words)))

(defun spamf-spam-file-p (filename &optional good-corpus bad-corpus)
  (let ((spamness (spamf-calculate-spamness-file filename
						 good-corpus bad-corpus)))
    (spamf-print-spamness-log spamness filename)
    (> (car spamness) spamf-spamness-limit)))

(defun spamf-spam-buffer-p (buffer &optional good-corpus bad-corpus)
  (let ((spamness (spamf-calculate-spamness-buffer buffer
						   good-corpus bad-corpus)))
    (spamf-print-spamness-log spamness (or (buffer-file-name buffer)
					   (buffer-name buffer)))
    (> (car spamness) spamf-spamness-limit)))

(defun spamf-spam-string-p (string &optional good-corpus bad-corpus)
  (let ((spamness (spamf-calculate-spamness-string string
						   good-corpus bad-corpus)))
    (spamf-print-spamness-log spamness)
    (> (car spamness) spamf-spamness-limit)))

(defun spamf-print-spamness-log (spamness &optional filename pop-to-buffer-p)
  (when spamf-debug-p
    (with-current-buffer (get-buffer-create "*spamfilter-log*")
      (goto-char (point-max))
      (insert (format "%s spamness is %S\n"
		      (or filename "String") (car spamness)))
      (dolist (item (sort (cadr spamness)
			  #'(lambda (x y) (> (cdr x) (cdr y))) ))
	(insert (format "  %S\n" item)))
      (insert "---\n")
      (goto-char (point-max))
      (when pop-to-buffer-p
	(pop-to-buffer (current-buffer))))))

;;; interactive
(defun spamf-register-good-directory (dirname &optional good-corpus)
  (interactive "DDirectory: ")
  (let ((good-corpus (or good-corpus spamf-good-corpus)))
    (spamf-register-words-directory good-corpus dirname)))

(defun spamf-register-spam-directory (dirname &optional bad-corpus)
  (interactive "DDirectory: ")
  (let ((bad-corpus (or bad-corpus spamf-bad-corpus)))
    (spamf-register-words-directory bad-corpus dirname)))

(defun spamf-register-good-file (filename &optional good-corpus)
  (interactive "fFile: ")
  (let ((good-corpus (or good-corpus spamf-good-corpus)))
    (spamf-register-words-file good-corpus filename)))

(defun spamf-register-spam-file (filename &optional bad-corpus)
  (interactive "fFile: ")
  (let ((bad-corpus (or bad-corpus spamf-bad-corpus)))
    (spamf-register-words-file bad-corpus filename)))

(defun spamf-register-good-buffer (buffer &optional good-corpus)
  (interactive "bBuffer: ")
  (let ((good-corpus (or good-corpus spamf-good-corpus)))
    (spamf-register-words-buffer good-corpus buffer)))

(defun spamf-register-spam-buffer (buffer &optional bad-corpus)
  (interactive "bBuffer: ")
  (let ((bad-corpus (or bad-corpus spamf-bad-corpus)))
    (spamf-register-words-buffer bad-corpus buffer)))

(defun spamf-register-good-string (string &optional good-corpus)
  (interactive "MString: ")
  (let ((good-corpus (or good-corpus spamf-good-corpus)))
    (spamf-register-words-string good-corpus string)))

(defun spamf-register-spam-string (string &optional bad-corpus)
  (interactive "MString: ")
  (let ((bad-corpus (or bad-corpus spamf-bad-corpus)))
    (spamf-register-words-string bad-corpus string)))

(defun spamf-delete-good-directory (dirname &optional good-corpus)
  (interactive "DDirectory: ")
  (let ((good-corpus (or good-corpus spamf-good-corpus)))
    (spamf-delete-words-directory good-corpus dirname)))

(defun spamf-delete-spam-directory (dirname &optional bad-corpus)
  (interactive "DDirectory: ")
  (let ((bad-corpus (or bad-corpus spamf-bad-corpus)))
    (spamf-delete-words-directory bad-corpus dirname)))

(defun spamf-delete-good-file (filename &optional good-corpus)
  (interactive "fFile: ")
  (let ((good-corpus (or good-corpus spamf-good-corpus)))
    (spamf-delete-words-file good-corpus filename)))

(defun spamf-delete-spam-file (filename &optional bad-corpus)
  (interactive "fFile: ")
  (let ((bad-corpus (or bad-corpus spamf-bad-corpus)))
    (spamf-delete-words-file bad-corpus filename)))

(defun spamf-delete-good-buffer (buffer &optional good-corpus)
  (interactive "bBuffer: ")
  (let ((good-corpus (or good-corpus spamf-good-corpus)))
    (spamf-delete-words-buffer good-corpus buffer)))

(defun spamf-delete-spam-buffer (buffer &optional bad-corpus)
  (interactive "bBuffer: ")
  (let ((bad-corpus (or bad-corpus spamf-bad-corpus)))
    (spamf-delete-words-buffer bad-corpus buffer)))

(defun spamf-delete-good-string (string &optional good-corpus)
  (interactive "MString: ")
  (let ((good-corpus (or good-corpus spamf-good-corpus)))
    (spamf-delete-words-string good-corpus string)))

(defun spamf-delete-spam-string (string &optional bad-corpus)
  (interactive "MString: ")
  (let ((bad-corpus (or bad-corpus spamf-bad-corpus)))
    (spamf-delete-words-string bad-corpus string)))

(defun spamf-spamness (&optional good-corpus bad-corpus)
  (interactive)
  (spamf-print-spamness-log (spamf-calculate-spamness-string
			     (spamf-buffer-string)
			     good-corpus bad-corpus)
			    nil
			    t))

(defun spamf-save-corpus (&optional filename good-corpus bad-corpus)
  (interactive "FFile: ")
  (let ((filename (or filename spamf-corpus-filename)))
    (spamf-message "Saving %s..." filename)
    (prog1 (spamf-save-corpus-to-file filename good-corpus bad-corpus)
      (spamf-message "Saving %s...done" filename))))

(defun spamf-load-corpus (&optional filename)
  (interactive "fFile: ")
  (let ((filename (or filename spamf-corpus-filename)))
    (spamf-message "Loading %s..." filename)
    (prog1 (spamf-load-corpus-from-file filename)
      (spamf-message "Loading %s...done" filename))))


(provide 'spamfilter)

;;; spamfilter.el ends here
