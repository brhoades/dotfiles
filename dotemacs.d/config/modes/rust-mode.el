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

(use-package flycheck-rust
  :ensure t
  :after (flycheck))


; 2025/04/07: emacs 30.1 busted rustic with error cannot find file or folder "s" in a require
(use-package rustic
  :ensure t
  :mode ("\\.rs\\'" . rustic-mode)
  :config
  (package-initialize)
  :hook ((rustic-mode . flycheck-rust-setup)
		 (rustic-mode . rustic-flycheck-setup)
		 (rustic-mode . lsp-mode)
         (rustic-mode . (lambda () (setenv "CARGO_TARGET_DIR" "/tmp/emacs-target-dir"))))
  :custom
  (package-native-compile t)
  (etq rust-mode-treesitter-derive t))


(use-package tree-sitter-langs
  :ensure t
  :after (tree-sitter))

(use-package tree-sitter
  :ensure t
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;(use-package rust-mode
;    :ensure t
;    :mode ("\\.rs\\'" . rust-mode)
;    :hook ((rust-mode . flycheck-rust-setup)
;           (rust-mode . lsp-mode)
;           (rust-mode . (lambda () (setenv "CARGO_TARGET_DIR" "/tmp/emacs-target-dir"))))
;    :init
;    (etq rust-mode-treesitter-derive t))




(defun lsp-cargo-toggle-target ()
  "Switches cargo's target between default and Windows"
  (interactive)
  (if (and
       (not (null lsp-rust-analyzer-cargo-target))
       (string-match "x86_64-pc-windows-gnu" lsp-rust-analyzer-cargo-target))
      ; then
      (progn
       (prin1 "switched cargo target to default")
       (setq lsp-rust-analyzer-cargo-target nil))
      ; else
      (progn
        (setq lsp-rust-analyzer-cargo-target "x86_64-pc-windows-gnu")
        (prin1 "switched cargo target to Windows"))))

(define-key global-map (kbd "<f9>") 'my-themes-select)
