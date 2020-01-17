(use-package company
  :ensure t
  :init
  (setq company-idle-delay nil  ; avoid auto completion popup, use TAB
                                ; to show it
        company-tooltip-align-annotations t)
  :hook (after-init . global-company-mode)
  :bind
  (:map prog-mode-map
        ("C-i" . company-indent-or-complete-common)
        ("C-M-i" . completion-at-point)))

(use-package company-lsp
  :ensure t
  :after (company lsp-mode)
  :custom
  (company-lsp-cache-candidates t)
)
