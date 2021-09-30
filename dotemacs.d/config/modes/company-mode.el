(use-package company
  :ensure t
  :commands (company-mode company-global-mode)
  :hook (after-init . global-company-mode)
  :bind
  (:map prog-mode-map
        ("C-i" . company-indent-or-complete-common)
		("C-M-i" . completion-at-point))
  :custom
  (company-idle-delay nil) ; avoid auto completion popup, use TAB
										; to show it
  (company-tooltip-align-annotations t))

