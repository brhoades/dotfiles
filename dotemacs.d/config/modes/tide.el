(use-package tide
  :ensure t
  :defer t
  :commands (tide-mode)
  :hook (typescript-mode . setup-tide-mode)
  :after (typescript-mode company-mode eldoc-mode flycheck-mode)
  :custom
  (tide-format-options (:indentSize 2 :tabSize 2 :baseIndentSize 2))
  )

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1)
  )
