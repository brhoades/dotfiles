(use-package lsp-mode
  :ensure t
  :after (company)
  ; https://gist.github.com/psanford/b5d2689ff1565ec7e46867245e3d2c76
  :commands (lsp lsp-deferred)
  :config
  (progn (setq lsp-prefer-flymake nil)) ;; flycheck
  ; :custom
  ; (flycheck-mode +0)
  ; (lsp-prefer-flymake :none)
)

(use-package lsp-ui
  :ensure t
  :after (lsp-mode)
  :hook ((lsp-mode-hook . lsp-ui-mode))
  :bind (("C-c e d" . lsp-ui-doc-show))
  ;; :custom
  ;; (lsp-ui-flycheck-enable :t)
  ;; (lsp-ui-sideline-delay 3.0)
  ;; (lsp-ui-doc-delay 3.0)
)
