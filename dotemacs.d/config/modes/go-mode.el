; http://tleyden.github.io/blog/2014/05/27/configure-emacs-as-a-go-editor-from-scratch-part-2/
(defun my-go-mode-hook ()
  ; Use goimports instead of go-fmt
  (setq gofmt-command "goimports")
  ; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Customize compile command to run go build
  ;(if (not (string-match "go" compile-command))
  ;    (set (make-local-variable 'compile-command)
  ;         "go build -v && go test -v && go vet"))
)

(use-package go-mode
  :defer t
  :ensure t
  :mode "\\.go\\'"
  ; http://tleyden.github.io/blog/2014/05/22/configure-emacs-as-a-go-editor-from-scratch/
  ; https://gist.github.com/psanford/b5d2689ff1565ec7e46867245e3d2c76
  :hook ((go-mode . flycheck-mode)
         (go-mode . my-go-mode-hook))

  ; ((go-mode . lsp-deferred)
  ; (before-save . lsp-format-buffer)
  ; (before-save . lsp-organize-imports))
  :custom
  ((flycheck-idle-change-delay 1)
   (tab-width 4)
   (indent-tabs-mode 1)
   (whitespace-style '(trailing)))
  )

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
