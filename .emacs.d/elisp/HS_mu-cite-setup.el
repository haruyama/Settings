(autoload 'mu-cite-original "mu-cite" nil t)
(add-hook 'mail-citation-hook 'mu-cite-original)
(setq mu-cite-top-format
      '("\n\nMessage-ID:" message-id "\n" 
        "Subject:" subject "\nにて\n" from " さんは書きました。\n\n"))

(add-hook 'mu-cite-pre-cite-hook
          '(lambda ()
             (save-excursion
               (goto-char (point-min))
               (replace-regexp "^春山\\(さん\\|氏\\)>" "春山>")
               (replace-regexp "^HARUYAMA\\(さん\\|氏\\)>" "HARUYAMA>"))))

(autoload 'lsdb-mu-insinuate "lsdb")
(eval-after-load "mu-cite"
                 '(lsdb-mu-insinuate))
