(use-package helm)
(use-package helm-config)
(use-package projectile)
(use-package helm-projectile)
(use-package helm-ag)
(use-package helm-smex)

(helm-mode 1)
(projectile-mode)
(helm-projectile-on)

(customize-set-variable 'helm-ff-lynx-style-map t) ; enable arrow key directory nav.

(customize-set-variable 'helm-ff-skip-boring-files t) ; skip boring files
(push "\.js\.map$" helm-boring-file-regexp-list)

(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(define-key helm-find-files-map "\t" 'helm-execute-persistent-action)
