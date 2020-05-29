;; Custom Shortcuts
; Open config
(global-set-key (kbd "C-c C-x i") (lambda() (interactive)(find-file "~/.emacs.d")))

; Open new org file
(global-set-key (kbd "C-c C-x o") (lambda() (interactive)(find-file "~/Documents/org")))

; Allow escape repeatedly to escape.
(global-set-key (kbd "<ESC> <ESC>") 'keyboard-escape-quit)
