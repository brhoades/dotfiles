; http://tleyden.github.io/blog/2014/05/27/configure-emacs-as-a-go-editor-from-scratch-part-2/
(defun my-go-mode-hook ()
  ; Use goimports instead of go-fmt
  (setq gofmt-command "goimports")
  ;; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
)

(defvar go-goto-override-keymap (make-keymap)
  "Keymap for go goto implementation overried (no godef)")

(define-minor-mode go-goto-override-minor-mode
  "Minor mode for fixing go goto impl"
  :init-value t
  :global t
  :keymap go-goto-override-keymap)

;; The keymaps in `emulation-mode-map-alists' take precedence over
;; `minor-mode-map-alist'
(add-to-list 'emulation-mode-map-alists
            `((go-goto-override-minor-mode . ,go-goto-override-keymap)))

(define-key go-goto-override-keymap (kbd "C-c C-j") 'lsp-goto-implementation)
(define-key go-goto-override-keymap (kbd "g d") 'lsp-goto-implementation)


(use-package go-mode
  :defer t
  :ensure t
  :mode "\\.go\\'"
  ; http://tleyden.github.io/blog/2014/05/22/configure-emacs-as-a-go-editor-from-scratch/
  ; https://gist.github.com/psanford/b5d2689ff1565ec7e46867245e3d2c76
  :hook ((go-mode . flycheck-mode)
         (go-mode . my-go-mode-hook)
         (go-mode . lsp-deferred)
         (go-mode . go-goto-override-minor-mode)
         (before-save . lsp-format-buffer)
         (before-save . lsp-organize-imports))
  :custom
  ((flycheck-idle-change-delay 1)
   (tab-width 4)
   (indent-tabs-mode 1)
   (whitespace-style '(trailing)))
)


(use-package go-projectile
    :ensure t
    :defer t
  :after (go-mode))

(use-package company-go
  :defer t
  :ensure t
  :after (go-mode company))

; https://github.com/flycheck/flycheck/issues/1523
(let ((govet (flycheck-checker-get 'go-vet 'command)))
  (when (equal (cadr govet) "tool")
    (setf (cdr govet) (cddr govet))))

(use-package go-projectile
  :after (go-mode projectile))
