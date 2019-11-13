(use-package python-mode)

(add-hook 'python-mode-hook
      (lambda ()
        (setq tab-width 4)
        (setq python-indent 4)))

(add-hook 'python-mode-hook
      'flycheck-mode)

(setq exec-path (cons "~/.pyenv/shims" exec-path))
