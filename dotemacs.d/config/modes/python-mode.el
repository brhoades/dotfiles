(use-package python-mode
  :ensure t
  :mode "\\.py\\'"
  :commands (python-mode)
  :hook (python-mode . flycheck-mode)
  :custom
  (tab-width 4)
  (python-indent 4)
)

(setq exec-path (cons "~/.pyenv/shims" exec-path))
