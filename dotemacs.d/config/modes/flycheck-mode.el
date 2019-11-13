(use-package flycheck)
(use-package flycheck-rust)
;; http://www.flycheck.org/manual/latest/index.html

;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)

;;;;;;;;;;;;;;;;;;;;; js
;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

;; use eslint with web-mode for jsx files
(with-eval-after-load 'flycheck
  (flycheck-add-mode 'javascript-eslint 'web-mode))

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(json-jsonlist)))

;; Set nvm path for eslint
(add-to-list 'exec-path "~/.nvm/v6.10.1/bin")
(setq flycheck-eslintrc "~/.eslintrc")

;; faster checking
(setq flycheck-highlighting-mode 'lines)

;; As long as eslint works, this speeds up opening buffers
;; https://github.com/flycheck/flycheck/issues/1129

(with-eval-after-load 'flycheck
  (advice-add 'flycheck-eslint-config-exists-p :override (lambda() t)))
