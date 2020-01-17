(use-package python-mode
  :ensure t
  :defer t
  :custom
  (tab-width 4)
  (python-indent 4)
)

(add-hook 'python-mode-hook
      'flycheck-mode)

(setq exec-path (cons "~/.pyenv/shims" exec-path))
