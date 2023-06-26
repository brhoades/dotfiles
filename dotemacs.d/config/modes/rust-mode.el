;; (use-package racer)
;; (use-package flycheck-rust)

;; (setq flycheck-rust-cargo-executable "/usr/sbin/cargo")
;; (with-eval-after-load 'rust-mode
 ;;  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

;; (add-hook 'rust-mode-hook #'racer-mode)
;; (add-hook 'rust-mode-hook #'eldoc-mode)
;; (add-hook 'rust-mode-hook #'rustic-mode)
;; (add-hook 'racer-mode-hook #'rustic-mode)
;; (add-hook 'rust-mode-hook #'company-mode)

;; (use-package company-lsp)
(setq company-tooltip-align-annotations t)

;; (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common) ;; Map TAB key to completions.
;; (define-key rust-mode-map (kbd "C-c C-j") #'lsp-find-definition)

;2023/06/11: having some issues with rustic-mode errors (lsp ui apparently),
;killing old packages
;(use-package flycheck-rust
;  :ensure t
;  :after (flycheck))

(use-package rustic
  :ensure t
  :mode ("\\.rs\\'" . rustic-mode)
  :hook ((rustic-mode . flycheck-rust-setup)
		 (rustic-mode . rustic-flycheck-setup)
		 (rustic-mode . lsp-mode))
  :custom
  (rustic-display-spinner nil))
