;; $Date: 1999/05/26 03:17:55 $ -*- emacs-lisp -*-
;; $Id: sample.dot.liece.in,v 1.1.1.1 1999/05/26 03:17:55 daiki Exp $

(setq riece-server-alist
      '(("localhost" :host "localhost" :port 6700 :nickname "haruyama" :coding iso-2022-jp)))
      ;'(("freenode" :host "irc.freenode.net" :nickname "haruyama" :coding utf-8)))
;; IRC Servers
;(setq liece-server "irc.kyoto.wide.ad.jp")
;(setq liece-server "irc.dti.ne.jp")
;(setq liece-server "irc.tokyo.wide.ad.jp:6663")
(setq riece-server "localhost:6700")
;(setq riece-server "freenode")

;; Port number of IRC Servers (default: 6667)
;(setq liece-service 6700)

;; Private information of user.
(setq riece-name "HARUYAMA Seigo / 春山征吾")
(setq riece-nickname "haruyama")
(setq riece-client-userinfo "http://www.unixuser.org/%7Eharuyama")

;;; Customization to change Look & Feel.
;; If non-nil, channel buffer would be displayed.
(setq riece-channel-buffer-mode t)
;; If non-nil, nick buffer would be displayed.
(setq riece-nick-buffer-mode t)
;; If non-nil, channel list buffer would be displayed.
(setq riece-channel-list-buffer-mode t)

;; Window splitting parameters.
(setq riece-nick-window-width-percent 18)
(setq riece-channel-list-window-width-percent 24)

;; Position of command buffer. (value: top or nil)
;; This setting is obsoleted.
;; See README-styles.ja, and Use styles.
;(setq riece-command-window-on-top nil)

(setq riece-window-style-directory "/usr/share/emacs/site-lisp/riece/styles")
;(setq riece-intl-catalogue-directory "/usr/local/share/riece/po")
;(setq riece-window-style-directory "/usr/local/share/riece/styles")
(setq riece-window-default-style "top")

;; Highlighten IRC buffers.
(setq riece-highlight-mode t)
;; If `riece-highlight-mode' is non-nil, strings which matches
;; following regular expression would be emphasized by colouring.
(setq riece-highlight-pattern
      (regexp-opt
       '("BSD" "emacs" "linux")))

;; Channels we want to join startup time.
;(setq riece-startup-channel-list
;      '("#foo" "#bar"))
;; Channel bindings to its numerical expression.
;; Each element of list are bound to n-th.
;(setq riece-default-channel-binding
;      '("#foo" nil "#baz" "#bar"))

;; DCC external programs.
;; When this is not specified, we search `dcc' executable in exec-path.
;(setq riece-dcc-program
;        (expand-file-name "/usr/local/share/riece/bin/dcc")
;      (expand-file-name "/usr/local/bin/dcc"))


;; Don't receive any files automatically.
;(setq riece-dcc-receive-direct nil)

;;; XEmacs specific features
;; Normal position of toolbar icons.
;(setq riece-icon-directory
;      (expand-file-name "/usr/local/share/riece/icons"))
;; Default toolbar position.
;(setq riece-toolbar-position 'top)
;; Display smiley mark.
;(setq riece-user-smiley t)

;;; URL browsing.
;; Specify browser name. To see available browser names,
;; refer docstring of `riece-url-browser-function'.
;(setq riece-url-browser-name "netscape")

;;; Encryption
;(setq riece-crypt-known-keys '("foo" "bar"))
;(setq riece-crypt-default-keys '(("#foo" . "bar")))

;;; Automatic invisible.
(add-hook 'riece-after-001-hook
       	  (function (lambda (prefix rest)
		      (riece-send
		       "MODE %s +i" riece-real-nickname)
		      nil)))

;;; For SKK users :)
(add-to-list 'riece-addons 'riece-skk-kakutei)

;(defadvice riece-command-enter-message
;  (before skk-kakutei activate)
;  (if (fboundp 'skk-kakutei)
;      (skk-kakutei)))

;;; Converting codings.
;; Detect coding automatically.
(setq riece-detect-coding-system t)
;; Convert deprecated hankaku kana to zenkaku kana.
;(setq riece-convert-hankaku-katakana t)

(setq riece-use-x-face t)
;(riece-command-ctcp-x-face-from-xbm-file '"~/.x-faces/bono.xbm")

(setq riece-use-localized-menu t)
(setq riece-max-buffer-size 6000)
