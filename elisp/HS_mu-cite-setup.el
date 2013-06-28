(autoload 'mu-cite-original "mu-cite" nil t)
(add-hook 'mail-citation-hook 'mu-cite-original)
(setq mu-cite-top-format
      '("\n\nMessage-ID:" message-id "\n" 
        "Subject:" subject "\n�ˤ�\n" from " ����Ͻ񤭤ޤ�����\n\n"))

(add-hook 'mu-cite-pre-cite-hook
          '(lambda ()
             (save-excursion
               (goto-char (point-min))
               (replace-regexp "^�ջ�\\(����\\|��\\)>" "�ջ�>")
               (replace-regexp "^HARUYAMA\\(����\\|��\\)>" "HARUYAMA>"))))

(autoload 'lsdb-mu-insinuate "lsdb")
(eval-after-load "mu-cite"
                 '(lsdb-mu-insinuate))
