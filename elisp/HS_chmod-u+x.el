(add-hook 'after-save-hook
          '(lambda ()
             (save-restriction
               (widen)
               (if (string= "#!" (buffer-substring 1 3))
                 (chmod-u+x (buffer-file-name))))))
(defun chmod-u+x (file)
  "Set all x-bits of file FILE."
  (interactive "fChmod a+x to file: ")
  (let ((octal-100 64))
    (set-file-modes file (logior (file-modes file) octal-100))))
