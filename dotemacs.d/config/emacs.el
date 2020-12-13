;; Save all tempfiles in $TMPDIR/emacs$UID/
(defconst emacs-tmp-dir (format "~/.emacs.d/tmp/backups/"))
(setq backup-directory-alist
      `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms
      `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix
      emacs-tmp-dir)
; (add-hook 'focus-out-hook 'save-all)

(define-coding-system-alias 'UTF-8 'utf-8)
(define-coding-system-alias 'utf8 'utf-8)

;; Save history
;; (push (cons 'buffer-undo-list buffer-undo-list) ll)

;; Whitespace config (no spaces)
(global-whitespace-mode)
(setq whitespace-style '(tabs newline tab-mark newline-mark))
; (set-face-attribute 'whitespace-space " " background nil :foreground "gray30")

;; Disable most GUI elements
(when window-system
  (tool-bar-mode 0)
  (scroll-bar-mode 0)
  (tooltip-mode 0))

;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-splash-screen t)

;; Save session buffers
(custom-set-variables
  '(desktop-auto-save-timeout 300)
  '(desktop-save-mode t)
  '(desktop-restore-eager 3)) ;; only load 3 most recent files, do the rest later

;; less verbose prompting
(fset 'yes-or-no-p 'y-or-n-p)

;; prevent accidental kills
(defun dont-kill-emacs()
    "Disable C-x C-c binding execute kill-emacs."
      (interactive)
        (error (substitute-command-keys "To exit emacs: \\[kill-emacs]")))
(global-set-key (kbd "C-x C-c") 'dont-kill-emacs)

;; straight
;(defvar bootstrap-version)
;(let ((bootstrap-file
;       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
;      (bootstrap-version 5))
;  (unless (file-exists-p bootstrap-file)
;    (with-current-buffer
;        (url-retrieve-synchronously
;         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
;         'silent 'inhibit-cookies)
;      (goto-char (point-max))
;      (eval-print-last-sexp)))
;  (load bootstrap-file nil 'nomessage))

;; refresh packages when needed
(unless package-archive-contents
  (package-refresh-contents))

; spaceemacs uses 100 MiB, I should too. Reduces CPU use.
; https://emacs.stackexchange.com/a/19715
(setq gc-cons-threshold 100000000) ; 100mb, default is 800kb
