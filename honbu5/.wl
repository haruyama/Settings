;; -*- mode: emacs-lisp; coding: euc-japan-unix -*-
;; vim: filetype=lisp

(setq charsets-mime-charset-alist
      (cons
        (cons (list 'unicode) 'utf-8)
        charsets-mime-charset-alist))
(setq wl-folder-notify-deleted t)
(setq wl-folder-check-async t)

;; [[ SEMI ������ ]]

;; HTML �ѡ��Ȥ�ɽ�����ʤ�
;; mime-setup �����ɤ�������˵��Ҥ���ɬ�פ�����ޤ���
(setq mime-setup-enable-inline-html nil)

;; �礭����å���������������ʬ�䤷�ʤ�
(setq mime-edit-split-message nil)

;; �礭����å������Ȥߤʤ��Կ�������
(setq mime-edit-message-default-max-lines 100000)
(setq mime-setup-enable-inline-image t)
(setq mime-edit-message-max-length nil)

;;; [[ �Ŀ;�������� ]]

(setq wl-from "HARUYAMA Seigo <haruyama@queen-ml.org>")
(setq wl-insert-mail-reply-to nil)
(setq wl-local-domain "queen-ml.org")

(setq wl-default-spec "+")
(setq wl-smtp-posting-server "scarlet-camel-91678cecd5d34ab7.znlc.jp")
(setq wl-smtp-posting-port 465)
(setq wl-smtp-connection-type 'ssl)
(setq wl-smtp-posting-user "haruyama")
(setq wl-smtp-authenticate-type "plain")

(setq wl-fcc "+fcc")
(setq wl-expire-alist
      '(("^\\+trash$"   (date 14) remove)
        ("^\\+spam$"   (date 60) remove)
        ;;         ("^\\+fcc$"   (date 7) trash)
        ))
(add-hook 'wl-summary-prepared-pre-hook
          'wl-summary-expire)
(setq wl-summary-expire-reserve-marks '("$" "!" "U"))
(setq wl-draft-always-delete-myself t)
(setq wl-interactive-exit nil)
(setq wl-interactive-send t)
(setq wl-default-folder "&haruyama@scarlet-camel-91678cecd5d34ab7.znlc.jp:995!")
(define-key wl-draft-mode-map "\C-c\C-i" 'insert-signature)
(define-key wl-draft-mode-map "\C-c[Tab]" 'insert-signature)
(defun mc-wl-verify-signature ()
  (interactive)
  (save-window-excursion
    (wl-summary-jump-to-current-message)
    (mc-verify)))

(defun mc-wl-decrypt-message ()
  (interactive)
  (save-window-excursion
    (wl-summary-jump-to-current-message)
    (let ((inhibit-read-only t))
      (mc-decrypt-message))))

(eval-after-load "mailcrypt"
                 '(setq mc-modes-alist
                        (append
                          (quote
                            ((wl-draft-mode (encrypt . mc-encrypt-message)
                                            (sign . mc-sign-message))
                             (wl-summary-mode (decrypt . mc-wl-decrypt-message)
                                              (verify . mc-wl-verify-signature))))
                          mc-modes-alist)))


(require 'lsdb)
(lsdb-wl-insinuate)
(add-hook 'wl-draft-mode-hook
          (lambda ()
            (define-key wl-draft-mode-map "\M-\t" 'lsdb-complete-name)))
(add-hook 'wl-summary-mode-hook
          (lambda ()
            (define-key wl-summary-mode-map ":" 'lsdb-wl-toggle-buffer)))
(define-key wl-summary-mode-map "b" 'wl-summary-prev-page)
(define-key wl-summary-mode-map "\C-h" 'wl-summary-prev-page)

(add-hook 'wl-mail-setup-hook
          (lambda ()
            (define-key (current-local-map) "\C-cf" 'select-xface)))
;; Summary �⡼�ɰܹԻ��� Folder �Хåե���Ĥ��ʤ�
(setq wl-stay-folder-window nil)

;; Summary �⡼�ɤ˰ܤ�Ȥ�, �ǽ�˥���åɤ򳫤��Ƥ���
(setq wl-thread-insert-opened t)

(setq message-locale-mime-charsets-alist
      '((en us-ascii)
        (fj us-ascii utf-8)
        (none)))


;;(setq message-locale-default 'none)
(setq message-locale-default 'fj)
;;(setq message-locale-default nil)
;;(setq message-locale-default 'en)

(setq wl-template-alist
      '(("default"
         ("From" . wl-from)
         )
        ("unixuser"
         ("From" . "HARUYAMA Seigo <haruyama@unixuser.org>")
         ("Sender" . wl-from)
         ("Reply-To" . wl-from)
         )
        ("engligh"
         ("From" . wl-from)
         (message-locale-default . 'en)
         (bottom . (concat "\n"
                           "-- \n"
                           "  HARUYAMA Seigo\n"
                           "  haruyama@queen-ml.org")
                 ))))


(defvar my-mime-filename-coding-system-for-decode
  '(utf-8 iso-2022-jp japanese-shift-jis japanese-iso-8bit))

(require 'mime-setup)
(eval-after-load "mime"
                 '(defadvice mime-entity-filename (around mime-decode activate)
                             ad-do-it
                             (and ad-return-value
                                  (setq ad-return-value (eword-decode-string ad-return-value)))))

(when nil
  (defun my-mime-decode-filename (filename)
    (let ((rest (eword-decode-string filename)))
      (or (when (and my-mime-filename-coding-system-for-decode
                     (string= rest filename))
            (let ((dcs (mapcar (function coding-system-base)
                               (detect-coding-string filename))))
              (unless (memq 'emacs-mule dcs)
                (let ((pcs my-mime-filename-coding-system-for-decode))
                  (while pcs
                         (if (memq (coding-system-base (car pcs)) dcs)
                           (setq rest (decode-coding-string filename (car pcs))
                                 pcs nil)
                           (setq pcs (cdr pcs))))))))
          rest)))

  (eval-after-load "mime"
                   '(defadvice mime-entity-filename (after eword-decode-for-broken-MUA activate)
                               "Decode encoded file name for BROKEN MUA."
                               (when (stringp ad-return-value)
                                 (setq ad-return-value (my-mime-decode-filename ad-return-value)))))

  (defadvice mime-entity-fetch-field
             (after mime-decode-entity activate)
             "MIME decode fetched field of entity."
             (if ad-return-value
               (setq ad-return-value (eword-decode-string (namajis-decode ad-return-value)))))
  (defun namajis-decode (s)
    (with-temp-buffer
      (insert s)
      (beginning-of-buffer)
      (while (re-search-forward "\033$[@B][^\033]+\033([BJ]" nil t)
             (decode-coding-region (match-beginning 0) (match-end 0) 'junet))
      (buffer-substring 1 (point-max)))))


(eval-after-load "mime"
                 '(defadvice mime-entity-filename (around mime-decode activate)
                             ad-do-it
                             (and ad-return-value
                                  (setq ad-return-value (eword-decode-string ad-return-value)))))

(defun filename-japanese-to-roman-string (str)
  (save-excursion
    (set-buffer (get-buffer-create " *temp kakasi*"))
    (erase-buffer)
    (insert str)
    (call-process-region
      (point-min)(point-max)
      "kakasi" t t t "-rk" "-Ha" "-Ka" "-Ja" "-Ea" "-ka")
    (buffer-string)))

;;ź�եե������mime�ǥ�����(�餷��)
(eval-after-load "mime"
                 '(defadvice mime-entity-filename (around mime-decode activate)
                             ad-do-it
                             (and ad-return-value
                                  (setq ad-return-value
                                        (eword-decode-string (decode-mime-charset-string
                                                               ad-return-value
                                                               'iso-2022-jp))))))

(setq wl-message-ignored-field-list
      '(".")
      wl-message-visible-field-list
      '("^\\(To\\|Subject\\|From\\|Date\\|Reply-To\\|References\\|X-Mailer*\\|In-Reply-To\\|Sender\\|X-Face\\|User-Agent\\|X-MimeOLE\\|Cc\\|Message-ID\\):"))


(setq elmo-msgdb-extra-fields
      '("x-ml-name"
        ;;        "reply-to"
        "sender"
        "mailing-list"
        ;        "newsgroups"
        "delivered-to"
        ))


(setq wl-refile-rule-alist
      '(
        ("Delivered-To"
         ("mailing list secureshell@securityfocus.com" . "+ml/secureshell")
         )
        ("Sender"
         ("owner-openssh-unix-dev@mindrot.org" . "+ml/openssh-unix-dev")
         ("anthy-dev-bounces@lists.sourceforge.jp". "+ml/anthy-dev")
         )
        ("To"
         ("queen-ml-admin@queen-ml.org" ."+ml/queen-ml-admin")
         ("queen-ml@queen-ml.org" ."+ml/queen-ml")
         ("daibo99@freeml.com" ."+ml/daibo")
         ("openssh-unix-dev@mindrot.org" ."+ml/openssh-unix-dev")
         ("openssh-unix-dev@shitei.mindrot.org" ."+ml/openssh-unix-dev")
         ("openssh@openssh.com" ."+ml/openssh-unix-dev")
         ("ssh@clinet.fi" ."+ml/openssh-unix-dev")
         ("openssh-unix-announce@mindrot.org" ."+ml/openssh-unix-announce")
         ("openssh-unix-announce@shitei.mindrot.org" ."+ml/openssh-unix-announce")
         ("memo@memo.st.ryukoku.ac.jp" . "+ml/security_hole-memo")
         ("weekly@freeml.com"  . "+trash")
         ("users-info@freeml.com" ."+trash")
         ("info@discount-domain.com"  . "+ml/info-onamae")
         ("info@onamae.com"  . "+ml/info-onamae")
         ("announce@list.jpcert.or.jp" . "+ml/jpcert-announce")
         ("announce@jpcert.or.jp" . "+ml/jpcert-announce")
         ("members-ml@unixuser.org" . "+ml/unixuser")
         ("ruby-list@ruby-lang.org" . "+ml/ruby-list")
         ("ruby-ext@ruby-lang.org" . "+ml/ruby-ext")
         ("ssh-admin@koka-in.org" . "+ml/ssh-admin@koka-in.org")
         )
        ("Cc"
         ("queen-ml-admin@queen-ml.org" ."+ml/queen-ml-admin")
         ("queen-ml@queen-ml.org" ."+ml/queen-ml")
         ("daibo99@freeml.com" ."+ml/daibo")
         ("openssh-unix-dev@mindrot.org" ."+ml/openssh-unix-dev")
         ("openssh-unix-dev@shitei.mindrot.org" ."+ml/openssh-unix-dev")
         ("ssh@clinet.fi" ."+ml/openssh-unix-dev")
         ("openssh@openssh.com" ."+ml/openssh-unix-dev")
         ("openssh-unix-announce@mindrot.org" ."+ml/openssh-unix-announce")
         ("openssh-unix-announce@shitei.mindrot.org" ."+ml/openssh-unix-announce")
         ("memo@memo.st.ryukoku.ac.jp" . "+ml/security_hole-memo")
         ("ruby-list@ruby-lang.org" . "+ml/ruby-list")
         ("ruby-ext@ruby-lang.org" . "+ml/ruby-ext")
         ("secureshell@securityfocus.com" . "+ml/secureshell")
         )
        ("From"
         ("info@onamae.com"  . "+ml/info-onamae")
         ("infomail@onamae.com"  . "+ml/info-onamae")
         ("vmwarenews@vmware.m0.net" . "+ml/vmware-news")
         )
        ("Subject"
         ("̤��ǧ����" . "+spam"))
        ))

(setq wl-biff-check-folder-list '("&haruyama@scarlet-camel-91678cecd5d34ab7.znlc.jp:995!"))
(setq wl-biff-check-interval 300)
(add-hook 'wl-summary-exit-hook
          'wl-biff-check-folders)


;; [[ spam �Ѥ����� ]]

;; �Хå�����ɤ� bogofilter ��Ȥ���������

;; ���ޥ�Хåե��� `o' (wl-summary-refile) ������, *�ǽ�*�� spam ����
;; ������Ƚ�ꤹ���ͤˤ���
;;(unless (memq 'wl-refile-guess-by-spam wl-refile-guess-functions)
;;  (setq wl-refile-guess-functions
;;       (cons #'wl-refile-guess-by-spam
;;             wl-refile-guess-functions)))


;; refile-rule ��ͥ�褷������� (spamfilter-wl.el �� bogofilter-wl.el
;; ��Ʊ������) ��, ���ä��������ͭ���ˤ���
;;(unless (memq 'wl-refile-guess-by-spam wl-auto-refile-guess-functions)
;;  (setq wl-auto-refile-guess-functions
;;       (append wl-auto-refile-guess-functions
;;               '(wl-refile-guess-by-spam))))

;; wl-spam-auto-check-folder-regexp-list �˹��פ���ե�����˰�ư����
;; ���� spam ���ɤ��������å�����
;;(add-hook 'wl-summary-prepared-pre-hook #'wl-summary-auto-check-spam)

;; refile �μ¹Ի��˳ؽ�������٤�����
;; �ʲ�������򤷤�����ȸ��äƾ�˳ؽ��������ǤϤ���ޤ���. �ܤ�����,
;; wl-spam.el �� wl-spam-undecided-folder-regexp-list ��
;; wl-spam-ignored-folder-regexp-list �� docstring �򻲾Ȥ��Ʋ�����.
;;(let ((actions wl-summary-mark-action-list)
;;      action)
;;  (while actions
;;    (setq action  (car actions)
;;         actions (cdr actions))
;;    (when (eq (wl-summary-action-symbol action) 'refile)
;;      (setcar (nthcdr 4 action) 'wl-summary-exec-action-refile-with-register)
;;      (setq actions nil))))

;;(setq elmo-msgdb-default-type 'standard
;;      elmo-msgdb-convert-type 'auto)
;;(setq wl-use-flag-folder-help-echot)

(require 'wl-spam)
(require 'spamfilter)
(setq elmo-spam-scheme 'spamfilter)
(require 'spamfilter-wl)
(setq wl-spam-folder-name "+spam")
(setq spamf-wl-spam-folder-name "+spam")
(setq wl-spam-auto-check-folder-regexp-list '("haruyama" "^\\."))
(setq wl-spam-undecided-folder-regexp-list '("haruyama" "^\\."))
(setq wl-spam-scheme 'spamfilter)
(setq elmo-spam-spamfilter-corpus-filename "~/.elmo/.spamfilter")

;; ��ե�����¹Ի��ˡ������ѥ���Ͽ��Ԥ鷺��̵�뤹��ե�����Υꥹ��
;;(setq spamf-wl-ignore-register-folder-names '("+trash" "+yuzin" "+ml" "+queue" "+draft"))
;;(setq wl-spam-ignored-folder-regexp-list '("\\+trash" "\\+yuzin" "\\+ml" "\\+queue" "\\+draft"))
(add-hook 'wl-hook
          #'(lambda ()
              ;; ChaSen ��Ȥ����
              ;; (unless chasen-process
              ;;   (chasen-async-open))
              (spamf-load-corpus "~/.elmo/.spamfilter")))
(add-hook 'wl-exit-hook
          #'(lambda ()
              ;; ChaSen ��Ȥ����
              ;; (chasen-async-close)
              (spamf-save-corpus "~/.elmo/.spamfilter")))

;;; tokenizer �λ���

;; ChaSen ��Ȥ����
;; (setq spamf-file-for-each-function   #'chasen-file-for-each)
;; (setq spamf-buffer-for-each-function #'chasen-buffer-for-each)
;; (setq spamf-string-for-each-function #'chasen-string-for-each)
;; (setq spamf-tokenize-file-function   #'chasen-tokenize-file)
;; (setq spamf-tokenize-buffer-function #'chasen-tokenize-buffer)
;; (setq spamf-tokenize-string-function #'chasen-tokenize-string)
;; chasen-process-send-string-limit ������̤��礭���ƥ����Ȥ�Ʊ���ץ�����Ȥ�
;; (setq chasen-process-send-string-limit (* 1024 2))

;; bigram ��Ȥ����
(setq spamf-file-for-each-function   #'jtoken-bigram-file-for-each)
(setq spamf-buffer-for-each-function #'jtoken-bigram-buffer-for-each)
(setq spamf-string-for-each-function #'jtoken-bigram-string-for-each)
(setq spamf-tokenize-file-function   #'jtoken-bigram-tokenize-file)
(setq spamf-tokenize-buffer-function #'jtoken-bigram-tokenize-buffer)
(setq spamf-tokenize-string-function #'jtoken-bigram-tokenize-string)

;; block ��Ȥ����
;; (setq spamf-file-for-each-function   #'jtoken-block-file-for-each)
;; (setq spamf-buffer-for-each-function #'jtoken-block-buffer-for-each)
;; (setq spamf-string-for-each-function #'jtoken-block-string-for-each)
;; (setq spamf-tokenize-file-function   #'jtoken-block-tokenize-file)
;; (setq spamf-tokenize-buffer-function #'jtoken-block-tokenize-buffer)
;; (setq spamf-tokenize-string-function #'jtoken-block-tokenize-string)
;;(setq elmo-split-folder "&haruyama@scarlet-camel-91678cecd5d34ab7.znlc.jp:995!")
;;(setq elmo-split-rule
;;      '(((spamfilter) "+spam") ; SPAM �� `+spam' ��
;;              (t "&haruyama@scarlet-camel-91678cecd5d34ab7.znlc.jp:995!")))         ; ����ʳ��� `+inbox' ��



;; ���ޥ�Хåե��� `o' (wl-summary-refile) ������, *�ǽ�*�� spam ����
;; ������Ƚ�ꤹ���ͤˤ���
;;(unless (memq 'wl-refile-guess-by-spam wl-refile-guess-functions)
;;  (setq wl-refile-guess-functions
;;    (cons #'wl-refile-guess-by-spam
;;          wl-refile-guess-functions)))

;; refile-rule ��ͥ�褷������� (spamfilter-wl.el �� bogofilter-wl.el
;; ��Ʊ������) ��, ���ä��������ͭ���ˤ���
(unless (memq 'wl-refile-guess-by-spam wl-auto-refile-guess-functions)
  (setq wl-auto-refile-guess-functions
        (append wl-auto-refile-guess-functions
                '(wl-refile-guess-by-spam))))

(setq elmo-msgdb-default-type 'standard
      elmo-msgdb-convert-type 'sync
      )

(autoload 'mu-cite-original "mu-cite" nil t)
(add-hook 'mail-citation-hook 'mu-cite-original)

(setq wl-summary-number-column-alist
      (append '(("^%inbox$" . 6) ("^+spam$" . 6))
              wl-summary-number-column-alist))

(add-hook 'wl-draft-mode-hook
          (lambda ()
            (add-to-list 'mime-charset-type-list '(utf-8 8 nil))))

;; Workaround for base64 with trailing garbage
;; http://thread.gmane.org/gmane.mail.wanderlust.general.japanese/7628/focus=7640
(require 'mime-def)
(mel-define-method mime-decode-string (string (nil "base64"))
                   (condition-case error
                                   (base64-decode-string string)
                                   (error
                                     (catch 'done
                                            (when (string-match
                                                    "\\([A-Za-z0-9+/ \t\r\n]+\\)=*" string)
                                              (let ((tail (substring string (match-end 0)))
                                                    (string (match-string 1 string)))
                                                (dotimes (i 3)
                                                  (condition-case nil
                                                                  (progn
                                                                    (setq string (base64-decode-string string))
                                                                    (throw 'done (concat string tail)))
                                                                  (error))
                                                  (setq string (concat string "=")))))
       (signal (car error) (cdr error))))))
