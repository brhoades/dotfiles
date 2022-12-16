(setq auto-mode-alist (delete '("\\.el$" . lisp-mode) auto-mode-alist))

(add-to-list 'auto-mode-alist '("\\.el$" . emacs-lisp-mode))
(add-hook 'emacs-lisp-mode (lambda() (
                                      'company-mode
									  'company-complete
                                      (add-to-list 'company-backends 'company-lsp)
                                      'lsp-mode)))

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            ;; Use spaces, not tabs.
            (setq indent-tabs-mode nil)
            ;; more sane argument alignment
            (setq lisp-indent-function 'common-lisp-indent-function)
            ;; Keep M-TAB for `completion-at-point'
            (define-key flyspell-mode-map "\M-\t" nil)
            ;; Pretty-print eval'd expressions.
            (define-key emacs-lisp-mode-map
              "\C-x\C-e" 'pp-eval-last-sexp)))
; (add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
