(use-package magit
  :ensure t
  :defer t
  :commands (magit-mode)
  :bind (("C-x g" . magit-status)))

(use-package evil-magit
  :after (magit)
  :defer t)

