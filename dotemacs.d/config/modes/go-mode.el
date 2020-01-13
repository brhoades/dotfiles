(use-package go-mode
  :ensure t
  :mode "\\.go\\'"
  :config
    (add-hook 'before-save-hook 'gofmt-before-save)
 ;; (with-eval-after-load 'go-mode
 ;;    (require 'go-autocomplete))
  :custom
    (flymake-mode) ;; disable flymake
	(tab-width 4)
    (indent-tabs-mode 1)
    (whitespace-style '(trailing))
	(flycheck-mode)
  :after (flycheck)
)

(use-package company-go
  :ensure t
  :after (go-mode company)
  )

; http://tleyden.github.io/blog/2014/05/22/configure-emacs-as-a-go-editor-from-scratch/

;;(defun auto-complete-for-go ()
 ;; (auto-complete-mode 1))

;;(add-hook 'go-mode-hook 'auto-complete-for-go)


; https://github.com/flycheck/flycheck/issues/1523
(let ((govet (flycheck-checker-get 'go-vet 'command)))
  (when (equal (cadr govet) "tool")
    (setf (cdr govet) (cddr govet))))
