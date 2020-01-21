(use-package add-node-modules-path
  :defer t
  :ensure t)

(use-package typescript-mode
  :ensure t
  :defer t
  :commands (typescript-mode)
  :hook (typescript-mode . add-node-modules-path)
  :mode "\\.tsx?\\'"
  :custom
    (typescript-indent-offset 2)
	(typescript-indent-level 2)
	(indent-tabs-mode nil)
  )
