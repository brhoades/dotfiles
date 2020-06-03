(use-package add-node-modules-path
  :ensure t)

(use-package typescript-mode
  :ensure t
  :hook ((typescript-mode . add-node-modules-path)
         (typescript-mode . setup-tide-mode)
         (typescript-mode . setup-tide-mode))
  :mode "\\.ts\\'"
  :custom
    ((typescript-indent-offset 2)
	(typescript-indent-level 2)
	(indent-tabs-mode nil)))
