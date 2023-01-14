(use-package lsp-mode
  :ensure t
  :after (company)
  ; https://gist.github.com/psanford/b5d2689ff1565ec7e46867245e3d2c76
  :commands (lsp lsp-deferred)
  :config
  (progn (setq lsp-prefer-flymake nil)) ;; flycheck
  :custom
  (lsp-prefer-flymake :none)
  (lsp-progress-via-spinner nil)
  (add-to-list 'lsp-language-id-configuration '(nix-mode . "nix"))
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("rnix-lsp"))
                    :major-modes '(nix-mode)
                    :server-id 'nix))
)

(use-package lsp-ui
  :ensure t
  :after (lsp-mode)
  :hook ((lsp-mode-hook . lsp-ui-mode))
  :bind (("C-c e u" . lsp-ui-doc-show))
  :custom
  (lsp-ui-doc-delay 10.0)
  (lsp-ui-flycheck-enable nil)
  (lsp-ui-sideline-show-hover :t)
  ;; (lsp-ui-sideline-delay 3.0)
)

(use-package yasnippet
  :ensure t)

(use-package helm-lsp
  :ensure t
  :after (helm lsp-mode))
