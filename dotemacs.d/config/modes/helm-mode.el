(require 'helm)
(require 'helm-config)
(require 'helm-projectile)
(require 'helm-config)


(helm-mode 1)

(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)

(define-key helm-find-files-map "\t" 'helm-execute-persistent-action)

(helm-projectile-on)
