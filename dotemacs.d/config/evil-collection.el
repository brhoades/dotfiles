(use-package evil-collection
  :ensure t
  :config
  (delq 'go-mode evil-collection-mode-list)
  (evil-collection-init))
