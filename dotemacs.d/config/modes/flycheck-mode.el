;; http://www.flycheck.org/manual/latest/index.html
(require 'flycheck)

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

; (setq flycheck-checkers '(javascript-eslint))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Exec path from shell
;; https://github.com/purcell/exec-path-from-shell
;; only need exec-path-from-shell on OSX
;; this hopefully sets up path and other vars better
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; Set nvm path for eslint
(add-to-list 'exec-path "/home/br046823/.nvm/v6.10.1/bin")
(setq flycheck-eslintrc "/home/br046823/.eslintrc")

;; faster checking
(setq flycheck-highlighting-mode 'lines)

;; use local eslint from node_modules before global
;; http://emacs.stackexchange.com/questions/21205/flycheck-with-file-relative-eslint-executable
;;
;;(defun my/use-eslint-from-node-modules ()
;;  (let* ((root (locate-dominating-file
;;   (or (buffer-file-name) default-directory)
;;         "node_modules"))
;;    eslint (and root
;;            (expand-file-name "node_modules/eslint/bin/eslint.js"
;;             root))))
;;    (when (and eslint (file-executable-p eslint))
;;      (setq-local flycheck-javascript-eslint-executable eslint))))
;;(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)
;;
;;(defadvice web-mode-highlight-part (around tweak-jsx activate)
;;  (if (equal web-mode-content-type "jsx")
;;    (let ((web-mode-enable-part-face nil))
;;      ad-do-it)
;;    ad-do-it))
