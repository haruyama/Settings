;;; japanese-tokenizer.el --- Tiny Japanese tokenizer.

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
;;
;;   Block tokenizer (from Mozilla)
;;     (jtoken-block-buffer-for-each #'print (current-buffer))
;;     (jtoken-block-tokenize-buffer (current-buffer))
;;
;;   Bigram tokenizer (from scbayes)
;;     (jtoken-bigram-buffer-for-each #'print (current-buffer))
;;     (jtoken-bigram-tokenize-buffer (current-buffer))


;;; Code:

(eval-when-compile
  (require 'cl))

;;;
;;; constant
;;;
(defconst jtoken-cvs-id "$Id: japanese-tokenizer.el,v 1.9 2003/12/10 15:05:42 ota Exp $")


;;;
;;; Block(?) tokenizer (from Mozilla)
;;;
;;; See http://slashdot.jp/comments.pl?sid=74119&cid=256727
;;;

;;; private functions
(defsubst jtoken-unibyte-p (char)
  "(< char 256)."
  (< char 256))

(defsubst jtoken-multibyte-p (char)
  "(< 255 char)."
  (< 255 char))

(defsubst jtoken-katakana-p (char)
  "ー or ァ-ヴ."
  (or (= ?ー char) (and (<= ?ァ char) (<= char ?ヴ))))

(defsubst jtoken-hiragana-p (char)
  "ー or ぁ-ん."
  (or (= ?ー char) (and (<= ?ぁ char) (<= char ?ん))))

(defsubst jtoken-zenkaku-alnum-p (char)
  "０-ｚ."
  (and (<= ?０ char) (<= char ?ｚ)))

(defsubst jtoken-kanji-p (char)
  "亜-瑤."
  (and (<= ?亜 char) (<= char ?瑤)))

(defsubst jtoken-newline-p (char)
  "\\n or \\r."
  (or (eq ?\n char) (eq ?\r char)))

(defsubst jtoken-punctuation-p (char)
  "。 or  、 or ・."
  (memq char '(?。 ?、 ?・)))

(defsubst jtoken-alnum-p (char)
  "alphabet or number."
  (and (< char 127)
       (or (and (<= ?a char) (<= char ?z))
	   (and (<= ?0 char) (<= char ?9))
	   (and (<= ?A char) (<= char ?Z))
	   (memq char '(?- ?' ?$ ?!)))))

(defsubst jtoken-number-char-list-p (chars)
  "[0-9]+"
  (dolist (char chars t)
    (unless (and char (<= ?0 char) (<= char ?9))
      (return nil))))

(defsubst jtoken-char-valid-p (object)
  "Wrapper for `char-valid-p'.
XEmacs では char-valid-p が無い場合があるようなので, 無い時は無条件で t を返す. ps-mule を読みこめばよいとの情報あり."
  (if (fboundp 'char-valid-p)
      (char-valid-p object)
    t))

(defsubst jtoken-buffer-string (&optional start end)
  "Wrapper for `buffer-substring-no-properties'."
  (buffer-substring-no-properties (or start (point-min)) (or end (point-max))))

(defsubst jtoken-read-char ()
  (let ((char (char-after)))
    (when char
      (forward-char)
      char)))

(defun jtoken-remove-if-not (jtoken-remove-if-not-function lst)
  "実行時に cl に依存するのを避けるため.
see `remove-if-not'."
  ;; inline?
  (let ((r nil))
    (dolist (item lst)
      (when (funcall jtoken-remove-if-not-function item)
	(push item r)))
    (nreverse r)))

(defun jtoken-divide-if-not (jtoken-divide-if-not-function lst)
  "実行時に cl に依存するのを避けるため.
see `position-if-not', `subseq'."
  (do ((r lst (cdr r))
       (l nil (cons (car r) l)))
      ((or (null r) (null (funcall jtoken-divide-if-not-function (car r))))
       (list (nreverse l) r))))

(defun jtoken-divide-japanese (jtoken-divide-japanese-function first chars)
  (when (funcall jtoken-divide-japanese-function first)
    (destructuring-bind (l r)
	(jtoken-divide-if-not jtoken-divide-japanese-function chars)
      (when (and l r)
	(list (apply #'string l) (apply #'string r))))))

(defun jtoken-divide-word (word)
  (let* ((chars (string-to-list word))
	 (first (car chars)))
    (cond ((jtoken-unibyte-p first) (list word))
	  ((jtoken-divide-japanese #'jtoken-zenkaku-alnum-p first chars))
	  ((jtoken-divide-japanese #'jtoken-katakana-p first chars))
	  ((jtoken-divide-japanese #'jtoken-hiragana-p first chars))
	  ((jtoken-divide-japanese #'jtoken-kanji-p first chars))
	  (t (list word)))))

(defsubst jtoken-split-kigou (string)
  (mapcar #'string (jtoken-remove-if-not #'jtoken-char-valid-p
					 (string-to-list string))))

(defun jtoken-block-get-words ()
  "M-f M-b M-f  M-f M-b M-f  ..."
  ;; TODO: refine
  (let* ((start (point))
	 (forward-result (forward-word 1)) ; M-f
	 (end (point)))
    (if (null forward-result)
	(unless (= start end) ; unless EOF
	  (jtoken-split-kigou (jtoken-buffer-string start end)))
      (let* ((backward-result (forward-word -1)) ; M-b
	     (backward-start (point)))
	(goto-char end) ; M-f
	(if (null backward-result) ; ?
	    (jtoken-divide-word (jtoken-buffer-string start end))
	  (if (< start backward-start)
	      (nconc (jtoken-split-kigou
		      (jtoken-buffer-string start backward-start))
		     (jtoken-divide-word
		      (jtoken-buffer-string backward-start end)))
	    (jtoken-divide-word (jtoken-buffer-string start end))))))))

(defun jtoken-for-each-to-list (jtoken-for-each-to-list-function &rest args)
  (let ((result nil))
    (apply jtoken-for-each-to-list-function
	   #'(lambda (item) (push item result))
	   args)
    (nreverse result)))


;;; public functions
(defun jtoken-block-buffer-for-each (jtoken-block-buffer-for-each-function
				     &optional buffer)
  (let ((buffer (or buffer (current-buffer))))
    (with-current-buffer buffer
      (save-excursion
	(goto-char (point-min))
	(do ((words (jtoken-block-get-words) (jtoken-block-get-words)))
	    ((null words) nil)
	  (dolist (word words)
	    (funcall jtoken-block-buffer-for-each-function word)))))))

(defun jtoken-block-file-for-each (jtoken-block-file-for-each-function filename)
  (with-temp-buffer
    (insert-file-contents filename)
    (jtoken-block-buffer-for-each jtoken-block-file-for-each-function
				  (current-buffer))))

(defun jtoken-block-string-for-each (jtoken-block-string-for-each-function string)
  (with-temp-buffer
    (insert string)
    (jtoken-block-buffer-for-each jtoken-block-string-for-each-function
				  (current-buffer))))

(defun jtoken-block-tokenize-buffer (&optional buffer)
  (jtoken-for-each-to-list #'jtoken-block-buffer-for-each buffer))

(defun jtoken-block-tokenize-file (filename)
  (jtoken-for-each-to-list #'jtoken-block-file-for-each filename))

(defun jtoken-block-tokenize-string (string)
  (jtoken-for-each-to-list #'jtoken-block-string-for-each string))


;;;
;;; Bigram tokenizer (from scbayes)
;;;
;;; See http://www.shiro.dreamhost.com/scheme/trans/spam-j.html
;;; See http://www.shiro.dreamhost.com/scheme/wiliki/wiliki.cgi?Gauche%3aSpamFilter%3a%cd%bd%c8%f7%bc%c2%b8%b3&l=jp
;;; See http://www.shiro.dreamhost.com/scheme/wiliki/wiliki.cgi?Gauche%3aSpamFilter&l=jp
;;;

;;; private functions
(defun jtoken-bigram-flush (jtoken-bigram-flush-function chars)
  (unless (or (null chars) (null (cdr chars)) (jtoken-number-char-list-p chars))
    (let ((chars (nreverse (jtoken-remove-if-not #'jtoken-char-valid-p
						 chars))))
      (when chars
	(funcall jtoken-bigram-flush-function (apply #'string chars))))))

(defun jtoken-bigram-alnum (jtoken-bigram-alnum-function char acc)
  (cond ((null char)
	 (jtoken-bigram-flush jtoken-bigram-alnum-function acc)
	 nil)
	((jtoken-multibyte-p char)
	 (jtoken-bigram-flush jtoken-bigram-alnum-function acc)
	 `(jtoken-bigram-multibyte ,jtoken-bigram-alnum-function
				   ,(jtoken-read-char) ,char))
	((jtoken-alnum-p char)
	 `(jtoken-bigram-alnum ,jtoken-bigram-alnum-function
			       ,(jtoken-read-char) ,(cons char acc)))
	(t
	 (jtoken-bigram-flush jtoken-bigram-alnum-function acc)
	 `(jtoken-bigram-blank ,jtoken-bigram-alnum-function
			       ,(jtoken-read-char) nil))))

(defun jtoken-bigram-blank (jtoken-bigram-blank-function char dummy)
  (cond ((null char) nil)
	((jtoken-multibyte-p char)
	 `(jtoken-bigram-multibyte ,jtoken-bigram-blank-function
				   ,(jtoken-read-char) ,char))
	((jtoken-alnum-p char)
	 `(jtoken-bigram-alnum ,jtoken-bigram-blank-function
			       ,(jtoken-read-char) ,(list char)))
	(t
	 `(jtoken-bigram-blank ,jtoken-bigram-blank-function
			       ,(jtoken-read-char) nil))))

(defun jtoken-bigram-multibyte (jtoken-bigram-multibyte-function char prev)
  (cond ((null char) nil)
	((jtoken-newline-p char) ; ignore newlines
	 `(jtoken-bigram-multibyte ,jtoken-bigram-multibyte-function
				   ,(jtoken-read-char) ,prev))
	((jtoken-multibyte-p char)
	 (cond ((jtoken-punctuation-p char)
		`(jtoken-bigram-multibyte ,jtoken-bigram-multibyte-function
					  ,(jtoken-read-char) nil))
	       (prev
		(unless (and (not (jtoken-kanji-p prev)) (jtoken-kanji-p char))
		  (jtoken-bigram-flush jtoken-bigram-multibyte-function
				       (list char prev)))
		`(jtoken-bigram-multibyte ,jtoken-bigram-multibyte-function
					  ,(jtoken-read-char) ,char))
	       (t
	       `(jtoken-bigram-multibyte ,jtoken-bigram-multibyte-function
					 ,(jtoken-read-char) ,char))))
	((jtoken-alnum-p char)
	 (jtoken-bigram-flush jtoken-bigram-multibyte-function (list prev))
	 `(jtoken-bigram-alnum ,jtoken-bigram-multibyte-function
			       ,(jtoken-read-char) ,(list char)))
	(t
	 `(jtoken-bigram-blank ,jtoken-bigram-multibyte-function
			       ,(jtoken-read-char) nil))))

;;; public functions
(defun jtoken-bigram-buffer-for-each (jtoken-bigram-buffer-for-each-function
				      &optional buffer)
  (let ((buffer (or buffer (current-buffer))))
    (with-current-buffer buffer
      (save-excursion
	(goto-char (point-min))
	(do ((next (jtoken-bigram-alnum jtoken-bigram-buffer-for-each-function
					(jtoken-read-char) nil)
		   (funcall (car next) (cadr next) (caddr next) (cadddr next))))
	    ((null next) nil))))))

(defun jtoken-bigram-file-for-each (jtoken-bigram-file-for-each-function
				    filename)
  (with-temp-buffer
    (insert-file-contents filename)
    (jtoken-bigram-buffer-for-each jtoken-bigram-file-for-each-function
				   (current-buffer))))

(defun jtoken-bigram-string-for-each (jtoken-bigram-string-for-each-function
				      string)
  (with-temp-buffer
    (insert string)
    (jtoken-bigram-buffer-for-each jtoken-bigram-string-for-each-function
				   (current-buffer))))

(defun jtoken-bigram-tokenize-buffer (&optional buffer)
  (jtoken-for-each-to-list #'jtoken-bigram-buffer-for-each buffer))

(defun jtoken-bigram-tokenize-file (filename)
  (jtoken-for-each-to-list #'jtoken-bigram-file-for-each filename))

(defun jtoken-bigram-tokenize-string (string)
  (jtoken-for-each-to-list #'jtoken-bigram-string-for-each string))

(provide 'japanese-tokenizer)

;;; japanese-tokenizer.el ends here
