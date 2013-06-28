(load-library "mailcrypt")
(mc-setversion "gpg")
(setq mc-gpg-keydir "/home/haruyama/.gnupg/")
;(setq mc-pgp-keydir "/home/haruyama/.gnupg/")
(setq mc-gpg-path  "/usr/bin/gpg")

(autoload 'mc-install-write-mode "mailcrypt" nil t)
(autoload 'mc-install-read-mode "mailcrypt" nil t)
(add-hook 'mail-mode-hook 'mc-install-write-mode)
