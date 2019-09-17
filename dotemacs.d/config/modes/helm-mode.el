(require 'helm)
(require 'helm-config)
(require 'projectile)
(require 'helm-projectile)

(helm-mode 1)
(projectile-mode)
(helm-projectile-on)

(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)


(define-key helm-find-files-map "\t" 'helm-execute-persistent-action)
