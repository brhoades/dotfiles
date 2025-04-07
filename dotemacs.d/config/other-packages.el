(use-package exec-path-from-shell
 :ensure t
 :config
 (exec-path-from-shell-initialize))
(use-package dockerfile-mode
 :ensure t
 :defer t)
(use-package js2-mode
 :ensure t
 :defer t)
(use-package yaml-mode
 :ensure t
 :defer t)
(use-package markdown-mode
 :ensure t
 :defer t)
(use-package flx-ido
 :ensure t)
(use-package nix-mode
 :ensure t
 :defer t)

(use-package solarized-theme
  :ensure t)
