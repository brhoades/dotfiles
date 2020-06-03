(use-package web-mode
  :ensure t
  :mode ("\\.html$" "\\.erb$" "\\.vue$" "\\.php$" "\\.tsx$" "\\.vue$")
  :config
    ; Don't try to line up ternaries. This allows them to indent when wrapped.
  (add-to-list 'web-mode-indentation-params '("lineup-ternary" . nil))
  :custom
    (web-mode-markup-indent-offset 2)
    (web-mode-css-indent-offset 2)
    (web-mode-code-indent-offset 2)
    (web-mode-auto-quote-style 2)
    (web-mode-enable-current-element-highlight t)
    (web-mode-enable-auto-quoting nil)
    ; allow periods in html tags
    (web-mode-html-tag-font-lock-keywords
      (list
       '("\\(</?\\)\\([[\\.:alnum:]]+\\)"
         (1 'web-mode-html-tag-bracket-face)
         (2 'web-mode-html-tag-face))
       '("\"[^\"]*\"" 0 'web-mode-html-attr-value-face)
       '("\\([[:alnum:]]+\\)" 1 'web-mode-html-attr-name-face)
       '("/?>" 0 'web-mode-html-tag-bracket-face)
       )))

