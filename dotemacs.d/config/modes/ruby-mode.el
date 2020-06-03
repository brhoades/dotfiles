(use-package rbenv
  :ensure t
  :config
  (global-rbenv-mode)
  :custom
  (rbenv-show-active-ruby-in-modeline nil))

(use-package enh-ruby-mode
  :ensure t
  :hook ((enh-ruby-mode . lsp-mode)
         (enh-ruby-mode . lsp)
         (enh-ruby-mode . setup-ruby-flycheck-mode)
         (enh-ruby-mode . company-mode))
  :mode "\\.rb\\'"
  :custom
  (lsp-ui-flycheck-live-reporting :t)
  (add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
  (add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode)))

;(use-package inf-ruby
;  :ensure t
;  :after enh-ruby-mode
;  :hook (enh-ruby-mode . inf-ruby-mode)
;  :bind ("C-c r r" . inf-ruby))

;(use-package ruby-hash-syntax
;  :ensure t
;  :hook (ruby-mode . ruby-hash-syntax-toggle))

(use-package projectile-rails
  :ensure t
  :after (projectile enh-ruby-mode)
  :config
  (projectile-rails-global-mode))

(use-package robe
  :ensure t
  :after enh-ruby-mode
  :config
  (global-robe-mode))

(defun setup-ruby-flycheck-mode ()
  (flycheck-add-next-checker 'lsp 'ruby-rubocop))

;; (require 'flymake-ruby)
;; (add-hook 'ruby-mode-hook 'flymake-ruby-load)

;; open a shell

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
