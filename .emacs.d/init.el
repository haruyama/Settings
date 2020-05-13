;;; init.el --- My init.el  -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Naoya Yamashita

;; Original Author: Naoya Yamashita <conao3@gmail.com>
;; https://qiita.com/conao3/items/347d7e472afd0c58fbd7

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:

;; this enables this running method
;;   emacs -q -l ~/.debug.emacs.d/{{pkg}}/init.el

(add-to-list 'load-path "~/.emacs.d/elisp")

(eval-and-compile
  (when (or load-file-name byte-compile-current-file)
    (setq user-emacs-directory
          (expand-file-name
           (file-name-directory (or load-file-name byte-compile-current-file))))))

(eval-and-compile
  (customize-set-variable
   'package-archives '(("org"   . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu"   . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))

(leaf leaf
  :config
  (leaf leaf-convert :ensure t)
  (leaf leaf-tree
    :ensure t
    :custom ((imenu-list-size . 30)
             (imenu-list-position . 'left))))

(leaf macrostep
  :ensure t
  :bind (("C-c e" . macrostep-expand)))

(leaf cus-edit
  :doc "tools for customizing Emacs and Lisp packages"
  :tag "builtin" "faces" "help"
  :custom `((custom-file . ,(locate-user-emacs-file "custom.el"))))

(leaf auto-complete)
(leaf ddskk
      :config (load "HS_skk-setup"))
(leaf flymake)
(leaf lsdb)
(leaf mu-cite)
(leaf recentf)
(leaf recentf-ext)
(leaf wl)

(keyboard-translate ?\C-h ?\C-?)
(define-key ctl-x-map "L" 'goto-line)

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

(provide 'init)

;; init.el ends here
