(global-set-key "\C-x\C-j" 'skk-mode)
(global-set-key "\C-o" 'skk-mode)
;(global-set-key "\C-o" 'toggle-input-method)
(global-set-key "\C-xj" 'skk-auto-fill-mode)
;(global-set-key "\C-xt" 'skk-tutorial)
(autoload 'skk-mode "skk" nil t)
(autoload 'skk-tutorial "skk-tut" nil t)
(autoload 'skk-check-jisyo "skk-tools" nil t)
(autoload 'skk-merge "skk-tools" nil t)
(autoload 'skk-diff "skk-tools" nil t)


(add-hook 'isearch-mode-hook
          (function (lambda ()
                      (and (boundp 'skk-mode) skk-mode
                           (skk-isearch-mode-setup) ))))
(add-hook 'isearch-mode-end-hook
          (function (lambda ()
                      (and (boundp 'skk-mode) skk-mode
                           (skk-isearch-mode-cleanup)
                           (skk-set-cursor-color-properly) ))))

(add-hook 'minibuffer-setup-hook
          (function
            (lambda ()
              (if (and (boundp 'skk-henkan-okuri-strictly)
                       skk-henkan-okuri-strictly
                       (not (eq last-command 'skk-purge-jisyo)))
                (progn
                  (setq skk-henkan-okuri-strictly nil)
                  (put 'skk-henkan-okuri-strictly 'temporary-nil t))))))

(add-hook 'minibuffer-exit-hook
          (function
            (lambda ()
              (if (get 'skk-henkan-okuri-strictly 'temporary-nil)
                (progn
                  (put 'skk-henkan-okuri-strictly 'temporary-nil nil)
                  (setq skk-henkan-okuri-strictly t))))))

(defun cancel-undo-boundary ()
  ;; buffer-undo-list の car の nil を消し、undo コマンドが直近のバッファ
  ;; の変更で止まらないようにする。buffer-undo-list における nil は、変
  ;; 更群と変更群の境界を示すデリミタの働きをしている。
  (if (and (consp buffer-undo-list)
           ;; car が nil だったらそれを消す。
           (null (car buffer-undo-list)) )
    (setq buffer-undo-list (cdr buffer-undo-list)) ))
