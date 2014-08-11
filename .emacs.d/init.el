;;auto-install
(setq auto-install-directory "~/.emacs.d/auto-install/")
(add-to-list 'load-path auto-install-directory)
(require 'auto-install)
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(require 'auto-async-byte-compile)
(setq auto-async-byte-complile-exclude-files-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

(savehist-mode t)
(setq-default save-place t)
(require 'saveplace)
(show-paren-mode t)
(line-number-mode t)
(column-number-mode t)
(transient-mark-mode t)
(setq find-file-existing-other-name t)
(display-time)

;(setq-default tab-width 2)
(setq-default tab-width 2 indent-tabs-mode nil)

(setq gc-cons-threshold (* 10 gc-cons-threshold))
(setq message-log-max 10000)
(setq enable-recursive-minibuffers t)
(setq use-dialog-box nil)
(defalias 'message-box 'message)

(setq history-length 1000)

(setq echo-keystrokes 1000)

(setq large-file-warning-threshold (* 25 1024 1024))

(defadvice abort-recursive-edit (before minibuffer-save activate)
           (when (eq (selected-window) (active-minibuffer-window))
             (add-to-history minibuffer-history-variable (minibuffer-contents))))

(ffap-bindings)

(require 'uniquify)
(setq uniquify-buffer-name-style `post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")

;key binding
(define-key global-map "\C-h" 'backward-delete-char)
(define-key global-map "\C-x\C-b"  'electric-buffer-list) 
(define-key global-map "\C-x\C-m"  'newline-and-indent)
(define-key ctl-x-map "L" 'goto-line)

(setq next-line-add-newlines nil)
(setq require-final-newline t)
(setq inhibit-default-init t)

(global-font-lock-mode t)

(setq completion-ignore-case t)

(setq pgp-version 'gpg)
(setq mime-pgp-command "gpg")
(setq pgg-default-scheme 'gpg pgg-scheme 'gpg)
(setq pgg-cache-passphrase t)

;(load "migemo")

(recentf-mode)
(setq recentf-max-saved-items 500)
(setq recentf-exclude '("/TAGS$" "/var/tmp"))
(require 'recentf-ext)
(define-key global-map "\C-z"  'recentf-open-files)

(require 'flymake)

(set-face-background 'flymake-errline "red4")
(set-face-background 'flymake-warnline "dark slate blue")

(package-initialize)

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
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(display-time-mode t)
 '(inhibit-startup-screen t)
 '(mime-view-type-subtype-score-alist (quote (((text . enriched) . 3) ((text . richtext) . 2) ((text . plain) . 4) ((text . html) . mime-view-text/html-entity-score) (multipart . mime-view-multipart-entity-score))))
 '(riece-desktop-notify-message-function (quote riece-message-text))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 139 :width normal :foundry "unknown" :family "VL Gothic")))))

(if (boundp 'window-system)
  (progn
    (set-mouse-color "maroon4")
    (set-cursor-color "wheat4")
    ;;モードライン
    ;(set-face-foreground 'modeline "wheat1")
    ;(set-face-background 'modeline "navy")
    (set-scroll-bar-mode 'left)

    (setq initial-frame-alist
          (append (list
                    '(width . 80) ;; ウィンドウ幅
                    '(height . 40) ;; ウィンドウの高さ
                    )
                  initial-frame-alist))))
(setq default-frame-alist initial-frame-alist)
(blink-cursor-mode 0)

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
(load "HS_skk-setup")
(load "text-adjust")
(setq text-adjust-hankaku-except "　？！＠ー〜、，．。（）")

(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl" "Write draft with Wanderlust." t)
(load "HS_mu-cite-setup")
;(load "HS_mailcrypt-setup")
(setq wl-folder-notify-deleted t)
(setq wl-folder-check-async t)

(setq pgp-version 'gpg)
(setq mime-pgp-command "gpg")
(setq pgg-default-scheme 'gpg pgg-scheme 'gpg)
(setq pgg-cache-passphrase t)
(setq pgg-gpg-use-agent t)

(autoload 'riece "riece" nil t)

(setq inferior-lisp-program "clisp")

;; http://www.emacswiki.org/emacs/SavePlace
(when (require 'saveplace nil t)
  (setq-default save-place t)
  (setq save-place-file "~/.emacs.d/saved-places"))

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(require 'paredit)
(show-paren-mode 1)
(add-hook 'oz-mode-hook 'enable-paredit-mode)
(add-hook 'clojure-mode-hook 'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook       'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook 'enable-paredit-mode)
(add-hook 'ielm-mode-hook             'enable-paredit-mode)
(add-hook 'lisp-mode-hook             'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'scheme-mode-hook           'enable-paredit-mode)

(define-key paredit-mode-map (kbd "{") 'paredit-open-brace)
(define-key paredit-mode-map (kbd "}") 'paredit-close-brace)
