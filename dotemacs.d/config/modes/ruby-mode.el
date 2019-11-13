(use-package rbenv)
(use-package inf-ruby)
(use-package ruby-hash-syntax)

; ruby does wild stuff inside parens...
(setq ruby-deep-indent-paren nil)

;; rbenv
;; (require 'rbenv)
;; (global-rbenv-mode)

;; Syntax checking
;; (require 'flymake-ruby)
;; (add-hook 'ruby-mode-hook 'flymake-ruby-load)

;; open a shell
(global-set-key (kbd "C-c r r") 'inf-ruby)

;; Rails projectile
(add-hook 'projectile-mode-hook 'projectile-rails-on)

;; robe
;; (require 'robe)
;; (add-hook 'ruby-mode-hook 'robe-mode)

;; robe with rbenv
;; (defadvice inf-ruby-console-auto (before rbenv-use-corresponding activate))

;; intelligent completion
;; (global-company-mode t)
;; (push 'company-robe company-backends)

;; execute irb
;; (define-key inf-ruby-minor-mode-map (kbd "C-c C-z") 'run-ruby)
