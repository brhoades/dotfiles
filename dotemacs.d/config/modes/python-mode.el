(use-package python-mode
  :ensure t
  :mode "\\.py\\'"
  :commands (python-mode)
  :hook ((python-mode . flycheck-mode)
         (python-mode . lsp-mode))
  :custom
  (tab-width 4)
  (python-indent 4)
)

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred

(setq exec-path (cons "~/.pyenv/shims" exec-path))
