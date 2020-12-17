(use-package flycheck
  :ensure t
  ;;(push 'rustic-clippy flycheck-checkers)
;;  ('rustic-clippy flycheck-checkers)
;;  (flycheck-mode . global-flycheck-mode)
;;  (setq-default flycheck-disabled-checkers
;;                (append flycheck-disabled-checkers
;;                        '(json-jsonlist)))
;;  (push 'flycheck-disabled-checkers javascript-disabled-checkers)
;;  (flycheck-add-mode 'javascript-eslint 'web-mode)
  :init
  (global-flycheck-mode)
  :custom
  (flycheck-highlighting-mode 'symbols)
  (flycheck-add-next-checker 'typescript-tide 'typescript-eslint)
  (flycheck-add-next-checker 'tsx-tide 'typescript-eslint)
  (set-face-attribute 'flycheck-error nil :underline '(:color "red2" :style wave))
  :config
  (push 'rustic-clippy flycheck-checkers)
  (push 'typescript-eslint flycheck-checkers)
  (push 'emacs-lisp-checkdoc flycheck-disabled-checkers)
  (push 'typescript-tslint flycheck-disabled-checkers))

;; Custom web-mode typescript eslint checker.
;; modified from tide.el and the eslint checker in flycheck.el.
;; https://github.com/ananthakumaran/tide/issues/328#issuecomment-532268282
;;
;; tslint is going out the door.

(flycheck-define-checker typescript-eslint
  "A Typescript syntax and style checker using eslint.
See URL `https://eslint.org/'."
  :command ("eslint" "--format=json"
            (option-list "--rulesdir" flycheck-eslint-rules-directories)
            (eval flycheck-eslint-args)
            "--stdin" "--stdin-filename" source-original)
  :standard-input t
  :error-parser flycheck-parse-eslint
  :modes web-mode
  :enabled (lambda () (string-suffix-p ".tsx" (buffer-file-name)))
  :working-directory flycheck-eslint--find-working-directory)
