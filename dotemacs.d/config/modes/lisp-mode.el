(setq auto-mode-alist (delete '("\\.el$" . lisp-mode) auto-mode-alist))

(add-to-list 'auto-mode-alist '("\\.el$" . emacs-lisp-mode))
(add-hook 'emacs-lisp-mode (lambda() (
                                      'company-mode
                                      (add-to-list 'company-backends 'company-lsp)
                                      'lsp-mode)))
