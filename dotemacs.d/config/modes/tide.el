(use-package tide
  :ensure t
  ; after races with these plugins.
  ; :after (web-mode typescript-mode company flycheck)
  :after flycheck
  :hook ((typescript-mode . setup-tide-mode)
         (web-mode . setup-tide-mode))
  :bind (("C-c j" . 'tide-jump-to-definition))
  :config
  (flycheck-add-next-checker 'tsx-tide 'typescript-eslint nil)
  (flycheck-add-next-checker 'typescript-tide 'javascript-eslint nil)
  (setq-default tide-format-options '(:indentSize 2 :tabSize 2 :baseIndentSize 2)))

(defun setup-tide-mode ()
  "Set up Tide mode."
  (interactive)
  (push 'typescript-tslint flycheck-disabled-checkers)
  (tide-setup)
  (flycheck-mode +1)
  ; (setq flycheck-check-syntax-automatically '(save-mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))
