(use-package flycheck
;;  :hook
;;  (flycheck-mode . global-flycheck-mode)
;;  (setq-default flycheck-disabled-checkers
;;                (append flycheck-disabled-checkers
;;                        '(json-jsonlist)))
;;  (push 'flycheck-disabled-checkers javascript-disabled-checkers)
;;  ('rustic-clippy flycheck-checkers)
;;  (flycheck-add-mode 'javascript-eslint 'web-mode)
;;  (advice-add 'flycheck-eslint-config-exists-p :override (lambda() t))
;;  :custom
  :init
  (flycheck-eslintrc "~/.eslintrc")
  (flycheck-highlighting-mode 'columns)
)
;; http://www.flycheck.org/manual/latest/index.html

;;;;;;;;;;;;;;;;;;;;; js
;; disable jshint since we prefer eslint checking

;; use eslint with web-mode for jsx files

;; disable json-jsonlist checking for json files
;; Set nvm path for eslint
(add-to-list 'exec-path "~/.nvm/v6.10.1/bin")


;; As long as eslint works, this speeds up opening buffers
;; https://github.com/flycheck/flycheck/issues/1129

