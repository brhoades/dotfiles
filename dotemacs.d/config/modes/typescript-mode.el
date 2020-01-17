(use-package typescript-mode
  :ensure t
  :defer t
  :commands (typescript-mode)
  :mode "\\.tsx?\\'"
  :custom
    (typescript-indent-offset 2)
  )
