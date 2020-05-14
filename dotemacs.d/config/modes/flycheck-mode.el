(use-package flycheck
  :ensure t
  ;;:hook
  ;;(push 'rustic-clippy flycheck-checkers)
;;  ('rustic-clippy flycheck-checkers)
;;  (flycheck-mode . global-flycheck-mode)
;;  (setq-default flycheck-disabled-checkers
;;                (append flycheck-disabled-checkers
;;                        '(json-jsonlist)))
;;  (push 'flycheck-disabled-checkers javascript-disabled-checkers)
;;  (flycheck-add-mode 'javascript-eslint 'web-mode)
;;  (advice-add 'flycheck-eslint-config-exists-p :override (lambda() t))
  :init
  (global-flycheck-mode)
  ; (flycheck-eslintrc "~/.eslintrc")
  (push 'rustic-clippy flycheck-checkers)
  :custom
  (flycheck-highlighting-mode 'symbols)
)
