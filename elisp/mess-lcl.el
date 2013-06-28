;;; mess-lcl.el --- Control message format with recipient's locale
;; Copyright (C) 1996,97,98 Free Software Foundation, Inc.

;; Author: Keiichi Suzuki   <keiichi@nanap.org>
;; Keywords: mail, news, MIME

;; This file is part of GNU Emacs.

;; GNU Emacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; This module controls message format with recipient's locale.

;;; Code:

(eval-when-compile
  (require 'cl)
  )

(require 'message)

(defgroup message-locale '((message-encode-function custom-variable))
  "Control message format with recipient."
  :link '(custom-manual "(message)Top")
  :group 'message)

(defcustom message-locale-default nil
  "Default locale for sending message."
  :group 'message-locale
  :type 'symbol)

(defcustom message-locale-detect-for-mail nil
  "*A function called to detect locale from recipient mail address."
  :group 'message-locale
  :type 'function)

(defcustom message-locale-detect-for-news
  'message-locale-detect-with-newsgroup-alist
  "*A function called to detect locale from newsgroup."
  :group 'message-locale
  :type 'function)

(defcustom message-mime-charset-recover-function
  'message-mime-charset-recover-by-ask
  "A function called to recover \
when could not found legal MIME charset for sending message."
  :type '(radio (function-item message-mime-charset-recover-by-ask)
		(function :tag "Other"))
  :group 'message-locale)

(defvar message-locale-newsgroup-alist
  '(("^fj\\." . fj)
    ))

(defvar message-locale-mail-address-alist nil)

(defcustom message-mime-charset-recover-ask-function
  'message-mime-charset-recover-ask-y-or-n
  "A function called to ask MIME charset.
This funtion will by called from \`message-mime-charset-recover-by-ask\'."
  :type '(radio (function-item message-mime-charset-recover-ask-y-or-n)
		(function-item message-mime-charset-recover-ask-charset)
		(function :tag "Other"))
  :group 'message-locale)

(defvar message-locale-mime-charsets-alist
  '((fj . (us-ascii iso-2022-jp iso-2022-jp-2))
    (none . nil)
    ))

(defface message-illegal-charsets-face
  '((((class color))
     (:foreground "black" :background "red"))
    (t
     (:bold t :underline t)))
  "Face used for displaying illegal charset."
  :group 'message-faces)

(defface message-warning-charsets-face
  '((((class color))
     (:foreground "black" :background "yellow"))
    (t
     (:bold t :underline t)))
  "Face used for displaying illegal charset."
  :group 'message-faces)


;;; Internal variable.
(defvar message-locale-args nil)


;;;
;;; Utility functions.
;;;
(defun message-set-charsets-face (charsets face &optional start end)
  (or start (setq start (point-min)))
  (or end (setq end (point-max)))
  (goto-char start)
  (when charsets
    (let (top)
      (while (< (point) end)
	(if (memq (charset-after) charsets)
	    (let ((start (point)))
	      (unless top
		(setq top (point)))
	      (forward-char 1)
	      (while (and (< (point) end)
			  (memq (charset-after) charsets))
		(forward-char 1))
	      (put-text-property start (point) 'face face))
	  (forward-char 1)))
      top)))

(defmacro message-locale-args (symbol)
  `(cdr (assq (quote ,symbol) message-locale-args))
  )

(defmacro message-locale-args-set (symbol val)
  `(setq message-locale-args
	 (put-alist (quote ,symbol) ,val message-locale-args))
  )

(defmacro message-locale-args-original (symbol)
  `(or (message-locale-args ,symbol) ,symbol)
  )

(defmacro message-locale-args-original-set (symbol)
  `(message-locale-args-set ,symbol ,symbol)
  )

;;;
;;; Call from message.el
;;;
(defun message-locale-maybe-encode ()
  "Control MIME encoding for message sending.

If would you like to control MIME encoding with recipient's locale,
then set this function to `message-encode-function'."
  (when message-mime-mode
    ;; Inherit the buffer local variable `mime-edit-pgp-processing'.
    (let ((pgp-processing (with-current-buffer message-edit-buffer
			    mime-edit-pgp-processing)))
      (setq mime-edit-pgp-processing pgp-processing))
    (run-hooks 'mime-edit-translate-hook))
  (let ((locale-list (message-locale-detect)))
    (when message-mime-mode
      (let ((message-save-encoder message-save-encoder)
	    (default-mime-charset-detect-method-for-write
	      default-mime-charset-detect-method-for-write)
	    (charsets-mime-charset-alist charsets-mime-charset-alist)
	    message-locale-args)
	(message-locale-setup-mime-charset locale-list)
	(when (catch 'mime-edit-error
		(save-excursion
		  (mime-edit-pgp-enclose-buffer)
		  (mime-edit-translate-body)))
	  (error "Translation error!")))
      (end-of-invisible)
      (run-hooks 'mime-edit-exit-hook))))

;;;
;;; Detect locale.
;;;
(defun message-locale-detect ()
  (when (or message-locale-detect-for-news
	    message-locale-detect-for-mail)
    (save-excursion
      (save-restriction
	(message-narrow-to-head)
	(let (lc dest)
	  (when message-locale-detect-for-news
	    (setq lc (mapcar
		      (lambda (newsgroup)
			(funcall message-locale-detect-for-news
				 (and (string-match "[^ \t]+" newsgroup)
				      (match-string 0 newsgroup))))
		      (message-tokenize-header
		       (message-fetch-field "newsgroups")))))
	  (when message-locale-detect-for-mail
	    (let ((field-list '("to" "cc" "bcc")))
	      (while (car field-list)
		(setq lc (append
			  lc
			  (mapcar
			   (lambda (address)
			     (funcall message-locale-detect-for-mail
				      (car
				       (cdr (std11-extract-address-components
					     address)))))
			   (message-tokenize-header
			    (message-fetch-field (pop field-list)))))))))
	  (setq lc (delq nil lc))
	  (while lc
	    (setq dest (cons (car lc) dest)
		  lc (delq (car lc) lc)))
	  (or dest
	      (and message-locale-default (list message-locale-default)))
	  )))))

(defun message-locale-detect-with-newsgroup-alist (newsgroup)
  (let ((rest message-locale-newsgroup-alist)
	done)
    (while (and (not done)
		rest)
      (when (string-match (car (car rest)) newsgroup)
	(setq done (car rest)))
      (setq rest (cdr rest)))
    (cdr done)
    ))

(defun message-locale-detect-with-mail-address-alist (address)
  (let ((rest message-locale-mail-address-alist)
	done)
    (while (and (not done)
		rest)
      (when (string-match (car (car rest)) address)
	(setq done (car rest)))
      (setq rest (cdr rest)))
    (cdr done)
    ))

;;;
;;; Control MIME charset with recipient's locale.
;;;
(defun message-locale-setup-mime-charset (locale-list)
  (message-locale-args-original-set charsets-mime-charset-alist)
  (message-locale-args-original-set
   default-mime-charset-detect-method-for-write)
  (setq default-mime-charset-detect-method-for-write
	(or message-mime-charset-recover-function
	    default-mime-charset-detect-method-for-write)
	message-save-encoder 'message-locale-mime-save-encoder)
  (let (locale-cs)
    (while (and charsets-mime-charset-alist
		locale-list)
      (unless (setq locale-cs
		    (assq (car locale-list)
			  message-locale-mime-charsets-alist))
	(error "Unknown locale \`%s\'. Add locale to \`%s\'."
	       (car locale-list)
	       'message-locale-mime-charsets-alist))
      (setq locale-cs (cdr locale-cs)
	    charsets-mime-charset-alist (delq nil
					   (mapcar
					    (lambda (cs)
					      (and (memq (cdr cs) locale-cs)
						   cs))
					    charsets-mime-charset-alist))
	    locale-list (cdr locale-list))
      )))

;;;
;;; Recover MIME charset.
;;;
(defun message-mime-charset-recover-by-ask (type charsets &rest args)
  (let ((default-charset
	  (let ((charsets-mime-charset-alist
		 (message-locale-args-original charsets-mime-charset-alist)))
	    (charsets-to-mime-charset charsets)))
	charset)
    (save-excursion
      (save-restriction
	(save-window-excursion
	  (when (eq type 'region)
	    (narrow-to-region (car args) (car (cdr args)))
	    (message-mime-highlight-illegal-chars charsets)
;	    (pop-to-buffer (current-buffer) nil t)
	    (pop-to-buffer (current-buffer) nil)
	    (recenter 1))
	  (if (setq charset
		    (funcall message-mime-charset-recover-ask-function
			     (upcase (symbol-name
				      (or default-charset
					  default-mime-charset-for-write)))
			     charsets))
		   (intern (downcase charset))
	    (throw 'message-sending-cancel t)))))))

(defun message-mime-charset-recover-ask-y-or-n (default-charset charsets)
  (and (y-or-n-p (format "MIME charset %s is selected. OK? "
			default-charset))
       default-charset))

(defun message-mime-charset-recover-ask-charset (default-charset charsets)
  (let ((alist (mapcar
		(lambda (cs)
		  (list (upcase (symbol-name cs))))
		(mime-charset-list)))
	charset)
    (while (not charset)
      (setq charset
	    (completing-read "What MIME charset: "
			     alist nil t default-charset))
      (when (string= charset "")
	(setq charset nil)))
    charset))

(defun message-mime-highlight-illegal-chars (charsets)
  (when charsets-mime-charset-alist
    (let* ((min 65535)
	   (delta-lists
	    (delq nil
		  (mapcar
		   (lambda (x)
		     (when (<= (length x) min)
		       x))
		   (delq nil (mapcar
			      (lambda (x)
				(setq x (delq nil
					      (mapcar
					       (lambda (y)
						 (unless (memq y (car x))
						   y))
					       charsets)
					      ))
				(when (<= (length x) min)
				  (setq min (length x))
				  x))
			      charsets-mime-charset-alist)))))
	   top cs done rest errors warns list)
      (while (setq top (pop delta-lists))
	(while (setq cs (pop top))
	  (setq done nil
		list delta-lists)
	  (when cs
	    (while (setq rest (pop list))
	      (if (setq rest (memq cs rest))
		  (setcar rest nil)
		(push cs warns)
		(setq done t)))
	    (unless done
	      (push cs errors)))))
      (put-text-property (point-min) (point-max) 'face nil)
      (if (setq top (message-set-charsets-face
		     errors
		     'message-illegal-charsets-face))
	  (message-set-charsets-face warns 'message-warning-charsets-face)
	(setq top (message-set-charsets-face
		   warns 'message-warning-charsets-face)))
      (if top
	  (goto-char top)
	(goto-char (point-min))))))

;;; @ for MIME Edit mode
;;;
(defun message-locale-mime-save-encoder (orig-buf)
  (when (with-current-buffer orig-buf mime-edit-mode-flag)
    (let ((charsets-mime-charset-alist
	   (message-locale-args-original charsets-mime-charset-alist))
	  (default-mime-charset-detect-method-for-write
	    (message-locale-args-original
	     default-mime-charset-detect-method-for-write)))
      (mime-edit-translate-body)
      (mime-edit-translate-header)
      )))

(run-hooks 'mess-lcl-load-hook)

(provide 'mess-lcl)

;;; mess-lcl.el ends here
