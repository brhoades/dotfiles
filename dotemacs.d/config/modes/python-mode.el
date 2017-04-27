(add-hook 'python-mode-hook
      (lambda ()
        (setq tab-width 4)
        (setq python-indent 4)))

(add-hook 'python-mode-hook
      'flycheck-mode)

(setq exec-path (cons "/Users/br046823/.pyenv/shims" exec-path))

;; Flymake
;; (when (load "flymake" t)
;;   (defun flymake-pyflakes-init ()
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;            (local-file (file-relative-name
;;                         temp-file
;;                         (file-name-directory buffer-file-name))))
;;       (list "pyflakes" (list local-file))))
;;   (add-to-list 'flymake-allowed-file-name-masks
;;                '("\\.py\\'" flymake-pyflakes-init)))
;;
;; (add-hook 'find-file-hook 'flymake-find-file-hook)
;; (;; delete '("\\.html?\\'" flymake-xml-init) flymake-allowed-file-name-masks)

;; Place temp files in a temp dir
;; (setq flymake-run-in-place t)
;; (setq temporary-file-directory "~/.emacs.d/flymake-tmp/")

;; jedi
; (add-hook 'python-mode-hook 'jedi:setup)
; (setq jedi:setup-keys t)
