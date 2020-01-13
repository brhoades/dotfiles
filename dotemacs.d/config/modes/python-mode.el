(use-package python-mode
  :ensure t
  :defer t
  :config
  (setq tab-width 4)
  (setq python-indent 4)
)

(add-hook 'python-mode-hook
      'flycheck-mode)

(setq exec-path (cons "~/.pyenv/shims" exec-path))
