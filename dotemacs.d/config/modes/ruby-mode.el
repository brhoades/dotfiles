(use-package rbenv
  :ensure t
  :defer t)

(use-package inf-ruby
  :commands (inf-ruby-mode)
  :hook (ruby-mode . inf-ruby-mode)
  :ensure t
  :defer t)

(use-package ruby-hash-syntax
  :commands (ruby-hash-syntax-toggle)
  :hook (ruby-mode . ruby-hash-syntax-toggle)
  :ensure t
  :defer t)

; ruby does wild stuff inside parens...
(setq ruby-deep-indent-paren nil)

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
