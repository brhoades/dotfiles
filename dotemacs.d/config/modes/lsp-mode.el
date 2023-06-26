(use-package lsp-mode
  :ensure t
  ; :quelpa ; 2023/06/11: lsp-mode has a bug in how it runs lenses that hits rust, use git
  ; this didn't help even though the latest commit seemed like it should
  ; (:upgrade t)
  :after (company)
  ; https://gist.github.com/psanford/b5d2689ff1565ec7e46867245e3d2c76
  :commands (lsp lsp-deferred)
  :hook ((before-save . lsp-format-buffer)
         (before-save . lsp-organize-imports))
  :bind (("C-c d" . lsp-describe-thing-at-point)
         ("C-c e d" . lsp-describe-thing-at-point)
         ;; ("C-c e u" . lsp-ui-doc-show)) -> lsp-ui
         ;; ("C-c e n" . flymake-goto-next-error)
         ;; ("C-c e p" . flymake-goto-prev-error)
         ("C-c e r" . lsp-find-references)
         ("C-c e R" . lsp-rename)
         ("C-c e i" . lsp-find-implementation)
         ("C-c C-j" . lsp-find-definition)
         ("C-c e t" . lsp-find-type-definition)
         ("C-c e C-d" . lsp-rust-analyzer-open-external-docs)
         ("C-c e a" . lsp-execute-code-action))
  :config
  (progn (setq lsp-prefer-flymake nil)) ;; flycheck
  :custom
  (lsp-lens-enable nil) ; bugged in current package in rust
  (lsp-prefer-flymake nil)
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
  ;; (lsp-ui-doc-delay 10.0)
  (lsp-ui-flycheck-enable t)
  (lsp-ui-sideline-show-hover t)
  ;; (lsp-ui-sideline-delay 3.0)
)

(use-package yasnippet
  :ensure t)

(use-package helm-lsp
  :ensure t
  :after (helm lsp-mode))

(use-package dap-mode
  :ensure t
  :config
  (dap-mode t)
  (dap-ui-mode t))
