(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ;("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")
                         ))

(require 'generic-x)

(require 'eieio)
(package-initialize)

(require `cl-lib)

(defvar installing-package-list
  '(apel
    auto-complete
    auto-save-buffers-enhanced
    auto-async-byte-compile
    cp5022x
    ddskk
    flim
    flymake
    fuzzy
;    helm
;    helm-ls-git
    magit
    markdown-mode
    mu-cite
    paredit
    popup
    recentf-ext
    semi
    session
    wanderlust))

;; refresh package list if it is not already available
(when (not package-archive-contents) (package-refresh-contents))

;; install packages from the list that are not yet installed
(dolist (pkg installing-package-list)
  (when (and (not (package-installed-p pkg)) (assoc pkg package-archive-contents))
    (package-install pkg)))

;(when  (require 'helm-config nil t)
;  (require 'helm-ls-git)
;  (helm-mode 1)

;  (global-set-key (kbd "M-x") 'helm-M-x)
;  (global-set-key (kbd "C-x C-f") 'helm-find-files)
;  (global-set-key (kbd "C-x C-b") 'helm-buffers-list)
;  (define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
;  (define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
;  (define-key helm-map  (kbd  "C-h") 'delete-backward-char)
;  (define-key helm-read-file-map (kbd "C-h") 'delete-backward-char)

;  (custom-set-variables `(helm-truncate-lines t))

  ; Disable helm in some functions
;  (add-to-list 'helm-completing-read-handlers-alist '(find-alternate-file . nil))

  ; Emulate `kill-line' in helm minibuffer
;  (setq helm-delete-minibuffer-contents-from-point t)
;  (defadvice helm-delete-minibuffer-contents (before helm-emulate-kill-line activate)
;    "Emulate `kill-line' in helm minibuffer"
;    (kill-new (buffer-substring (point) (field-end))))

;  (defadvice helm-ff-kill-or-find-buffer-fname (around execute-only-if-exist activate)
;    "Execute command only if CANDIDATE exists"
;    (when (file-exists-p candidate)
;      ad-do-it))

;  (defadvice helm-ff-transform-fname-for-completion (around my-transform activate)
;    "Transform the pattern to reflect my intention"
;    (let* ((pattern (ad-get-arg 0))
;           (input-pattern (file-name-nondirectory pattern))
;           (dirname (file-name-directory pattern)))
;      (setq input-pattern (replace-regexp-in-string "\\." "\\\\." input-pattern))
;      (setq ad-return-value
;            (concat dirname
;                    (if (string-match "^\\^" input-pattern)
                        ; '^' is a pattern for basename
                        ; and not required because the directory name is prepended
;                        (substring input-pattern 1)
;                      (concat ".*" input-pattern))))))
;  )

(require 'auto-async-byte-compile)
(defvar auto-async-byte-complile-exclude-files-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

(blink-cursor-mode 0)
(column-number-mode t)
(display-time-mode t)
(global-font-lock-mode t)
(line-number-mode t)

(savehist-mode t)
(setq-default save-place t)
(show-paren-mode t)
(defvar who-paren-style 'mixed)
(transient-mark-mode t)

(setq-default tab-width 2 indent-tabs-mode nil)

(setq completion-ignore-case t)
(setq echo-keystrokes 1000)
(setq enable-recursive-minibuffers t)
(setq find-file-existing-other-name t)
(setq gc-cons-threshold (* 10 gc-cons-threshold))
(setq history-length 1000)
(setq inhibit-default-init t)
(setq large-file-warning-threshold (* 25 1024 1024))
(setq make-backup-files nil)
(setq message-log-max 10000)
(setq next-line-add-newlines nil)
(setq require-final-newline t)
(setq use-dialog-box nil)

(defalias 'message-box 'message)

(defadvice abort-recursive-edit (before minibuffer-save activate)
  (when (eq (selected-window) (active-minibuffer-window))
    (add-to-history minibuffer-history-variable (minibuffer-contents))))

(ffap-bindings)

(require 'uniquify)
(setq uniquify-buffer-name-style `post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")

                                        ;key binding
(keyboard-translate ?\C-h ?\C-?)
                                        ;(define-key global-map "\C-h" 'backward-delete-char)
(define-key global-map "\C-x\C-b"  'electric-buffer-list)
(define-key global-map "\C-x\C-m"  'newline-and-indent)
(define-key ctl-x-map "L" 'goto-line)

(recentf-mode)
(defvar recentf-max-saved-items 500)
(defvar recentf-exclude '("/TAGS$" "/var/tmp"))
(require 'recentf-ext)
(define-key global-map "\C-z"  'recentf-open-files)

(require 'flymake)
(set-face-background 'flymake-errline "red4")
(set-face-background 'flymake-warnline "dark slate blue")

(require 'auto-complete-config)
(global-auto-complete-mode t)
(add-to-list 'ac-modes 'text-mode)
(add-to-list 'ac-modes 'oz-mode)
(setq ac-ignore-case t)
(setq ac-use-menu-map t)
;; デフォルトで設定済み
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

;; 整形済み
(setq-default ac-sources '(ac-source-words-in-same-mode-buffers
                           ac-source-filename
                           ac-source-functions
                           ac-source-yasnippet
                           ac-source-variables
                           ac-source-symbols
                           ac-source-features
                           ac-source-abbrev
                           ac-source-dictionary
                           ac-source-words-in-all-buffer))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(mime-view-type-subtype-score-alist
   (quote
    (((text . enriched)
      . 3)
     ((text . richtext)
      . 2)
     ((text . plain)
      . 4)
     ((text . html)
      . mime-view-text/html-entity-score)
     (multipart . mime-view-multipart-entity-score))))
 '(package-selected-packages
   (quote
    (wanderlust session recentf-ext paredit markdown-mode magit helm-ls-git fuzzy ddskk cp5022x auto-save-buffers-enhanced auto-complete auto-async-byte-compile)))
 '(riece-desktop-notify-message-function (quote riece-message-text))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 139 :width normal :foundry "unknown" :family "VL Gothic")))))

(if (display-graphic-p)
    (progn
      (set-mouse-color "maroon4")
      (set-cursor-color "wheat4")
      ;;モードライン
      (set-scroll-bar-mode 'right)

      (setq initial-frame-alist
            (append (list
                     '(width . 80) ;; ウィンドウ幅
                     '(height . 40) ;; ウィンドウの高さ
                     )
                    initial-frame-alist))))
(setq default-frame-alist initial-frame-alist)

(global-set-key "\M-/" 'hippie-expand)
(setq hippie-expand-try-functions-list
      '(try-complete-file-name-partially
        try-complete-file-name
        try-expand-abbrev
        try-expand-all-abbrevs
        try-expand-list try-expand-line
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

(add-to-list 'load-path "~/.emacs.d/elisp")

(load "HS_gosh")
(when  (require 'skk nil t)
  (load "HS_skk-setup"))
(load "text-adjust")
(defvar text-adjust-hankaku-except "　？！＠ー〜, , . . （）")

(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl" "Write draft with Wanderlust." t)
(load "HS_mu-cite-setup")
                                        ;(load "HS_mailcrypt-setup")

(defvar pgp-version 'gpg)
(defvar mime-pgp-command "gpg")
(defvar pgg-default-scheme 'gpg)
(defvar pgg-scheme 'gpg)
(defvar pgg-cache-passphrase t)
(defvar pgg-gpg-use-agent t)

(autoload 'riece "riece" nil t)

;; http://www.emacswiki.org/emacs/SavePlace
(when (require 'saveplace nil t)
  (setq-default save-place t)
  (defvar save-place-file "~/.emacs.d/saved-places"))

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(require 'paredit)
(dolist (mode '(oz-mode
                clojure-mode
                emacs-lisp-mode
                scheme-mode
                eval-expression-minibuffer-setup
                ielm-mode
                lisp-mode
                lisp-interaction-mode))
  (add-hook (intern (format "%s-hook" mode))
            (lambda ()
              (add-to-list (make-local-variable 'paredit-space-for-delimiter-predicates)
                           (lambda (a b) nil))
              (enable-paredit-mode))))

(add-hook 'oz-mode-hook
          (lambda ()
            (define-key paredit-mode-map (kbd "{") 'paredit-open-curly)
            (define-key paredit-mode-map (kbd "}") 'paredit-close-curly)))


(require 'diff-mode)

