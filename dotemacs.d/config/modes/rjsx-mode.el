(use-package rjsx-mode
  :ensure t
  :defer t
  :mode "\\(components\\|containers\\)\\/.*\\.jsx?\\'"
  :custom
    (js2-strict-trailing-comma-warning nil)
  :bind (("<" . nil) ("C-d" . nil))
  )
