(use-package flycheck
  :ensure t
;;  :hook
;;  (flycheck-mode . global-flycheck-mode)
;;  (setq-default flycheck-disabled-checkers
;;                (append flycheck-disabled-checkers
;;                        '(json-jsonlist)))
;;  (push 'flycheck-disabled-checkers javascript-disabled-checkers)
;;  ('rustic-clippy flycheck-checkers)
;;  (flycheck-add-mode 'javascript-eslint 'web-mode)
;;  (advice-add 'flycheck-eslint-config-exists-p :override (lambda() t))
  :custom
    (flycheck-eslintrc "~/.eslintrc")
    ; (flycheck-highlighting-mode 'symbols)
)
