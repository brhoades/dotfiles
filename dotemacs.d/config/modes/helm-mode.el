(use-package helm
  :ensure t
  :custom
  ; https://github.com/tonsky/FiraCode/issues/158
  (auto-composition-mode nil)
  :config
  (helm-mode 1)
  (push "\.(js|ts)x?\.map$" helm-boring-file-regexp-list)
  (push "\.pb\.(go|js|py)$" helm-boring-file-regexp-list))

(use-package projectile
  :ensure t
  :config
  (projectile-mode)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))
  ; :custom
  ; (projectile-globally-ignored-directories '("node_modules")))

(use-package helm-ag
  :after helm
  :ensure t)
  ;:custom
  ;(auto-composition-mode nil))

(use-package helm-rg
  :after helm
  :ensure t)


(use-package helm-smex
  :ensure t
  :after helm
  :bind (("M-x" . helm-M-x)))

(use-package helm-projectile
  :ensure t
  :after helm
  :config
  (helm-projectile-on))


(customize-set-variable 'helm-ff-lynx-style-map t) ; enable arrow key directory nav.
(customize-set-variable 'helm-ff-skip-boring-files t) ; skip boring files

(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)

(define-key helm-find-files-map "\t" 'helm-execute-persistent-action)
(setq projectile-sort-order 'recentf)
