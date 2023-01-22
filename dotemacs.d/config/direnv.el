; If it's blocked, don't tell me
(use-package direnv
 :ensure t
 :config
 (add-to-list 'warning-suppress-types '(direnv)))
