(use-package exec-path-from-shell
 :ensure t
 :config
 ; MacOS + GUI
 (when (window-system)
  (when (featurep 'ns-win)
    (exec-path-from-shell-initialize))))
(use-package dockerfile-mode
 :ensure t
 :defer t)
(use-package exec-path-from-shell
 :ensure t
 :defer t
 :exec
 (when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize)))
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
