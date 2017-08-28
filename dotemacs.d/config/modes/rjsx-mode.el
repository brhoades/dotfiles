(require 'rjsx-mode)

(add-to-list 'auto-mode-alist '("\\(components\\|containers\\)\\/.*\\.jsx?\\'" . rjsx-mode))

(add-hook 'rjsx-mode-hook
  (lambda ()
    (setq js2-strict-trailing-comma-warning nil)
  )
)

(with-eval-after-load 'rjsx
  (define-key rjsx-mode-map "<" nil)
  (define-key rjsx-mode-map (kbd "C-d") nil))
