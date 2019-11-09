(setq package-archives '(("melpa" . "http://melpa.milkbox.net/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)

;;;;;;;;;;;;;;; Evil mode
;; Enable global evil mode early, so if something else breaks I still have arms
(require 'evil)
(evil-mode 1)
;;;;;;;;;;;;;;;

(setq-default indent-tabs-mode nil)
(setq tab-width 2)

; (infer-indentation-style)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(auto-revert-remote-files t)
 '(c-label-minimum-indentation 2)
 '(compilation-message-face (quote default))
 '(custom-enabled-themes (quote (misterioso)))
 '(desktop-restore-eager 3)
 '(desktop-save-mode t)
 '(fci-rule-color "#3C3D37")
 '(helm-ff-lynx-style-map t)
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
 '(indent-tabs-mode nil)
 '(magit-diff-use-overlays nil)
 '(org-agenda-files
   (quote
    ("~/Documents/org/topics/17/Q1/releaser.org" "~/Documents/org/agenda/work.org" "~/Documents/org/agenda/home.org")))
 '(package-selected-packages
   (quote
    (go-autocomplete go-imports protobuf-mode go-mode helm-ag flycheck-rust rust-mode projectile-rails evil-magit magit rjsx-mode neotree dockerfile-mode jsx-mode haskell-mode purescript-mode less-css-mode flycheck-pyflakes tide exec-path-from-shell flycheck web-mode js2-mode vue-mode elm-mode helm-smex scala-mode yaml-mode rbenv inf-ruby smex evil-smartparens ruby-hash-syntax timesheet el-get jedi json-mode markdown-mode bug-hunter helm-projectile flx-ido projectile helm evil)))
 '(pos-tip-background-color "#A6E22E")
 '(pos-tip-foreground-color "#272822")
 '(ruby-align-to-stmt-keywords nil)
 '(ruby-deep-arglist nil)
 '(ruby-deep-indent-paren nil)
 '(typescript-indent-level 2)
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
(define-global-minor-mode my-global-whitespace-mode whitespace-mode
  (lambda ()
    (when (not (memq major-mode
                     (list 'go-mode)))
      (whitespace-mode))))
(my-global-whitespace-mode 1)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;;;;;;;;;;;;; Modular Config
; https://www.emacswiki.org/emacs/DotEmacsModular
(defun load-directory (directory)
  "Load recursively all `.el' files in DIRECTORY."
  (dolist (element (directory-files-and-attributes directory nil nil nil))
    (let* ((path (car element))
           (fullpath (concat directory "/" path))
           (isdir (car (cdr element)))
           (ignore-dir (or (string= path ".") (string= path ".."))))
      (cond
       ((and (eq isdir t) (not ignore-dir))
        (load-directory fullpath))
       ((and (eq isdir nil) (string= (substring path -3) ".el"))
        (load (file-name-sans-extension fullpath)))))))

(load-directory "~/.emacs.d/config")
;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;; Themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'monokai t)
;;;;;;;;;;;;;;;
