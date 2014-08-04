;;; spamfilter-wl.el --- spam filter for Wanderlust

;; Copyright (C) 2003 Susumu Ota

;; Author: Susumu ota <ccbcc@black.livedoor.com>
;; Keywords: SPAM, filter, Wanderlust

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
;;   See README


;;; Code:

(eval-when-compile
  (require 'cl))

(require 'spamfilter)


;;;
;;; constant
;;;
(defconst spamf-wl-cvs-id "$Id: spamfilter-wl.el,v 1.5 2003/10/19 14:39:00 ota Exp $")

;;;
;;; parameter
;;;
(defvar spamf-wl-spam-folder-name "+spam"
  "SPAM folder name.")

(defvar spamf-wl-ignore-register-folder-names nil
  "Ignore folder list.")

;;;
;;; utility
;;;
(defun spamf-wl-get-buffer (&optional folder number)
  (let ((folder (or folder wl-summary-buffer-elmo-folder))
	(number (or number (wl-summary-message-number))))
    (wl-summary-toggle-disp-msg 'off)
    (if (wl-summary-no-mime-p folder)
	(wl-summary-redisplay-no-mime-internal folder number)
      (wl-summary-redisplay-internal folder number))
    (wl-summary-toggle-disp-msg 'off)
    wl-message-buffer))


;;;
;;; interactive
;;;
(defun spamf-wl-spam-p (&optional folder number)
  (interactive)
  (let ((folder (or folder wl-summary-buffer-elmo-folder))
	(number (or number (wl-summary-message-number))))
    (let ((filename (elmo-message-file-name folder number)))
      (spamf-message "spamf-wl-spam-p: %s Processing..." filename)
      (let ((result (spamf-spam-buffer-p (spamf-wl-get-buffer folder number))))
	(spamf-message "spamf-wl-spam-p: %s Processing...done. %s"
		       filename (if result "SPAM" "GOOD"))
	result))))

(defun spamf-wl-register-good (&optional folder number)
  (interactive)
  (spamf-register-good-buffer (spamf-wl-get-buffer folder number)))

(defun spamf-wl-register-spam (&optional folder number)
  (interactive)
  (spamf-register-spam-buffer (spamf-wl-get-buffer folder number)))

(defun spamf-wl-register-good-folder (&optional folder number-list)
  (interactive)
  (let ((folder (or folder wl-summary-buffer-elmo-folder))
	(number-list (or number-list wl-summary-buffer-number-list)))
    (let ((end (length number-list)) (n 0))
      (dolist (number number-list)
	(spamf-wl-register-good folder number)
	(spamf-message "spamf-wl-register-good-folder: %d/%d" (incf n) end)))))

(defun spamf-wl-register-spam-folder (&optional folder number-list)
  (interactive)
  (let ((folder (or folder wl-summary-buffer-elmo-folder))
	(number-list (or number-list wl-summary-buffer-number-list)))
    (let ((end (length number-list)) (n 0))
      (dolist (number number-list)
	(spamf-wl-register-spam folder number)
	(spamf-message "spamf-wl-register-spam-folder: %d/%d" (incf n) end)))))


;;;
;;; advice
;;;
(defadvice wl-refile-guess-by-rule (after
				    spamf-wl-refile-guess-by-rule
				    activate)
  (unless ad-return-value
    (when (spamf-wl-spam-p wl-summary-buffer-elmo-folder
			   (wl-summary-message-number))
      (setq ad-return-value spamf-wl-spam-folder-name))))

(defadvice wl-summary-exec-subr (before
				 spamf-wl-summary-exec-subr
				 activate)
  (mapcar #'(lambda (item)
	      (if (equal spamf-wl-spam-folder-name (cdr item))
		  (spamf-wl-register-spam wl-summary-buffer-elmo-folder
					  (car item))
		(unless (member (cdr item)
				spamf-wl-ignore-register-folder-names)
		  (spamf-wl-register-good wl-summary-buffer-elmo-folder
					  (car item)))))
	  wl-summary-buffer-refile-list))

(defun spamf-wl-enable-spamfilter ()
  (interactive)
  (ad-enable-advice 'wl-refile-guess-by-rule
		    'after
		    'spamf-wl-refile-guess-by-rule)
  (ad-activate 'wl-refile-guess-by-rule)
  (ad-enable-advice 'wl-summary-exec-subr
		    'before
		    'spamf-wl-summary-exec-subr)
  (ad-activate 'wl-summary-exec-subr))

(defun spamf-wl-disable-spamfilter ()
  (interactive)
  (ad-disable-advice 'wl-refile-guess-by-rule
		     'after
		     'spamf-wl-refile-guess-by-rule)
  (ad-activate 'wl-refile-guess-by-rule)
  (ad-disable-advice 'wl-summary-exec-subr
		     'before
		     'spamf-wl-summary-exec-subr)
  (ad-activate 'wl-summary-exec-subr))


;;; elmo-split
(defun elmo-split-spamfilter (buffer)
  (spamf-spam-buffer-p buffer))


;;; obsolete

;;; (defadvice wl-refile-guess-by-rule (after
;;;                                     spamf-wl-refile-guess-by-rule
;;;                                     activate)
;;;   (unless ad-return-value
;;;     (let ((filename (elmo-message-file-name wl-summary-buffer-elmo-folder
;;;                                             (wl-summary-message-number))))
;;;       (when (and (file-readable-p filename) (spamf-spam-file-p filename))
;;;         (setq ad-return-value spamf-wl-spam-folder-name)))))

;;; (defadvice wl-summary-exec-subr (before
;;;                                  spamf-wl-summary-exec-subr
;;;                                  activate)
;;;   (mapcar #'(lambda (item)
;;;               (let ((filename (elmo-message-file-name
;;;                                wl-summary-buffer-elmo-folder
;;;                                (car item))))
;;;                 (when (file-readable-p filename)
;;;                   (if (equal spamf-wl-spam-folder-name (cdr item))
;;;                       (spamf-register-spam-file filename)
;;;                     (spamf-register-good-file filename)))))
;;;           wl-summary-buffer-refile-list))

(provide 'spamfilter-wl)

;;; spamfilter-wl.el ends here
