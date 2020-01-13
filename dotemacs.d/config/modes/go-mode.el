(use-package go-mode
  :mode
  "\\.go"
  :config
  (add-hook 'before-save-hook 'gofmt-before-save)
  (add-hook 'go-mode-hook 'lsp-deferred)
 ;; (with-eval-after-load 'go-mode
;;    (require 'go-autocomplete))
  :custom
    (tab-width 4)
    (indent-tabs-mode 1)
    (whitespace-style '(trailing))
)

(use-package company-go
  :mode
  "\\.go\\'"
  :after (go-mode company)
  )
(use-package go-lsp
  :mode
  "\\.go\\'"
  :config
  (add-hook 'go-mode-hook 'lsp-deferred)
  :after (go-mode)
)


; http://tleyden.github.io/blog/2014/05/22/configure-emacs-as-a-go-editor-from-scratch/

;;(defun auto-complete-for-go ()
 ;; (auto-complete-mode 1))

;;(add-hook 'go-mode-hook 'auto-complete-for-go)



; https://github.com/flycheck/flycheck/issues/1523
(let ((govet (flycheck-checker-get 'go-vet 'command)))
  (when (equal (cadr govet) "tool")
    (setf (cdr govet) (cddr govet))))
