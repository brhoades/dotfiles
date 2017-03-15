(setq package-archives '(("melpa" . "http://melpa.milkbox.net/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)

;;;;;;;;;;;;;;; Emacs Config
;; Save all tempfiles in $TMPDIR/emacs$UID/
(defconst emacs-tmp-dir (format "~/.emacs.d/tmp/backups/"))
(setq backup-directory-alist
      `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms
      `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix
      emacs-tmp-dir)
(add-hook 'focus-out-hook 'save-all)

(define-coding-system-alias 'UTF-8 'utf-8)
(define-coding-system-alias 'utf8 'utf-8)

;; Always save our buffers and load them on start
(desktop-save-mode 1)
(setq desktop-auto-save-timeout 300)

;; Save history
(add-to-list 'desktop-locals-to-save 'buffer-undo-list)

;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; Whitespace config (no spaces)
(global-whitespace-mode)
(setq whitespace-style '(tabs newline tab-mark newline-mark))
; (set-face-attribute 'whitespace-space " " background nil :foreground "gray30")

;;smex (better M-x)
(global-set-key [(meta x)] (lambda ()
                             (interactive)
                             (or (boundp 'smex-cache)
                                 (smex-initialize))
                             (global-set-key [(meta x)] 'smex)
                             (smex)))

(global-set-key [(shift meta x)] (lambda ()
                                   (interactive)
                                   (or (boundp 'smex-cache)
                                       (smex-initialize))
                                   (global-set-key [(shift meta x)] 'smex-major-mode-commands)
                                   (smex-major-mode-commands)))


; https://github.com/syl20bnr/spacemacs/issues/2626
; Fix for some restored sessions causing buffer lists to break.
; (push '(persp . :never) frameset-filter-alist)
;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;; Ruby Config
; ruby does wild stuff inside parens...
(setq ruby-deep-indent-paren nil)

;; rbenv
;; (require 'rbenv)
;; (global-rbenv-mode)

;; Syntax checking
;; (require 'flymake-ruby)
;; (add-hook 'ruby-mode-hook 'flymake-ruby-load)

;; open a shell
(global-set-key (kbd "C-c r r") 'inf-ruby)

;; Rails projectile
(add-hook 'projectile-mode-hook 'projectile-rails-on)

;; robe
;; (require 'robe)
;; (add-hook 'ruby-mode-hook 'robe-mode)

;; robe with rbenv
;; (defadvice inf-ruby-console-auto (before rbenv-use-corresponding activate))

;; intelligent completion
;; (global-company-mode t)
;; (push 'company-robe company-backends)

;; execute irb
;; (define-key inf-ruby-minor-mode-map (kbd "C-c C-z") 'run-ruby)
;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;
;; Custom Shortcuts
; Open config
(global-set-key (kbd "C-c C-x i") (lambda() (interactive)(find-file "~/.emacs.d")))

; Open new org file
(global-set-key (kbd "C-c C-x o") (lambda() (interactive)(find-file "~/Documents/org")))

;;;;;;;;;;;;;;;

(require 'evil)
(evil-mode 1)

(require 'helm)
(require 'helm-config)
(helm-mode 1)

(require 'projectile)
(projectile-mode 1)
(setq projectile-enable-caching t)
(add-to-list 'projectile-globally-ignored-directories "node_modules")

(require 'flx)
(require 'flx-ido)

;; (setq helm-projectile-fuzzy-match nil)
(require 'helm-projectile)
(helm-projectile-on)

(require 'pony-mode)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'monokai t)

(setq-default indent-tabs-mode nil)
(setq tab-width 2)

(add-hook 'python-mode-hook
      (lambda ()
        (setq tab-width 4)
        (setq python-indent 4)))

; (infer-indentation-style)

;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-splash-screen t)

;; Save session buffers
(desktop-save-mode 1)

;; Hide toolbar
(tool-bar-mode -1)

;;;;;;;;;;;;;;org-mode configuration
;; Enable org-mode
(require 'org)
;; Make org-mode work with files ending in .org
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;; Python

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
;; (setq exec-path (cons "/Users/br046823/.pyenv/shims" exec-path))
;; (;; delete '("\\.html?\\'" flymake-xml-init) flymake-allowed-file-name-masks)

;; Place temp files in a temp dir
;; (setq flymake-run-in-place t)
;; (setq temporary-file-directory "~/.emacs.d/flymake-tmp/")

;; jedi
; (add-hook 'python-mode-hook 'jedi:setup)
; (setq jedi:setup-keys t)
;;;;;;;;;;;;;;; End Python

;;;;;;;;;;;;;;; JSON mode
'(setq js-indent-level 2)
(add-hook 'json-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 2)))
;;;;;;;;;;;;;;; End JSON

;;;;;;;;;;;;;;; Coffeescript
;; This gives you a tab of 2 spaces
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(auto-revert-remote-files t)
 '(coffee-indent-like-python-mode t)
 '(coffee-tab-width 2)
 '(compilation-message-face (quote default))
 '(custom-enabled-themes (quote (misterioso)))
 '(fci-rule-color "#3C3D37")
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors
   (quote
    (("#3C3D37" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#3C3D37" . 100))))
 '(magit-diff-use-overlays nil)
 '(package-selected-packages
   (quote
    (helm-smex scala-mode yaml-mode rbenv inf-ruby smex evil-smartparens ruby-hash-syntax coffee-mode timesheet el-get jedi json-mode markdown-mode bug-hunter pony-mode helm-projectile flx-ido projectile helm evil)))
 '(pos-tip-background-color "#A6E22E")
 '(pos-tip-foreground-color "#272822")
 '(ruby-align-to-stmt-keywords nil)
 '(ruby-deep-arglist nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (unspecified "#272822" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0")))

;; automatically clean up bad whitespace
(setq whitespace-action '(auto-cleanup))

;; only show bad whitespace
(setq whitespace-style '(trailing space-before-tab indentation empty space-after-tab))

;; evil mode

;;;;;;;;;;;;;;;


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;; Custom keybinds
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
