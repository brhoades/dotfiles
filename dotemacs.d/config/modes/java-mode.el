(use-package hydra
    :ensure t)

(use-package lsp-java
  :ensure t)

(add-hook 'java-mode-hook 'flycheck)
(add-hook 'java-mode-hook 'company-mode)
(add-hook 'java-mode-hook 'lsp-java-boot)
(add-hook 'java-mode-hook 'company-lsp)

(add-to-list 'auto-mode-alist '("\\.java\\'" . java-mode))
