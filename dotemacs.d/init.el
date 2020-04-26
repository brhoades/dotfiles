(package-initialize)
;; use-package setup
(load "~/.emacs.d/config/use-package.el")

;;;;;;;;;;;;;;; Evil mode
;; Enable global evil mode early, so if something else breaks I still have arms
(use-package evil
  :init
  (setq evil-want-keybinding nil)
  :ensure t)
(use-package evil-smartparens
  :ensure t)
(evil-mode 1)
;;;;;;;;;;;;;;;

(setq-default indent-tabs-mode nil)
(setq tab-width 2)

(setq tramp-default-method "ssh")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(add-to-list (quote org-file-apps) t)
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(auto-composition-mode nil t)
 '(auto-revert-remote-files t)
 '(c-label-minimum-indentation 2)
 '(company-idle-delay nil)
 '(company-lsp-cache-candidates t)
 '(company-tooltip-align-annotations t)
 '(compilation-message-face (quote default))
 '(custom-enabled-themes (quote (misterioso)))
 '(custom-safe-themes
   (quote
    ("7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" "e9df267a1c808451735f2958730a30892d9a2ad6879fb2ae0b939a29ebf31b63" "0fffa9669425ff140ff2ae8568c7719705ef33b7a927a0ba7c5e2ffcfac09b75" "13a8eaddb003fd0d561096e11e1a91b029d3c9d64554f8e897b2513dbf14b277" "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" default)))
 '(desktop-restore-eager 3)
 '(desktop-save-mode t)
 '(fci-rule-color "#3C3D37")
 '(flycheck-eslintrc "~/.eslintrc" t)
 '(flycheck-highlighting-mode (quote symbols))
 '(flycheck-idle-change-delay 1)
 '(flymake-mode 0 t)
 '(helm-ff-lynx-style-map t)
 '(helm-ff-skip-boring-files t)
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
 '(js-indent-level 2)
 '(js2-strict-trailing-comma-warning nil t)
 '(lsp-ui-doc-delay 15)
 '(magit-diff-use-overlays nil)
 '(notmuch-search-oldest-first nil t)
 '(org-agenda-files
   (quote
    ("~/Documents/org/agenda/work.org" "~/Documents/org/agenda/home.org")) nil nil "Customized with use-package org")
 '(org-noter-always-create-frame nil)
 '(org-noter-kill-frame-at-session-end nil)
 '(package-selected-packages
   (quote
    (org org-noter org-pdfview pdf-tools evil-collection helm-notmuch notmuch helm-config protobuf-mode lsp-ui lsp-ui-sideline company-go flycheck-rust python-mode company-lsp lsp-mode nix-mode diminish use-package go-autocomplete go-imports go-mode helm-ag projectile-rails evil-magit magit rjsx-mode neotree dockerfile-mode jsx-mode haskell-mode purescript-mode less-css-mode flycheck-pyflakes tide exec-path-from-shell flycheck web-mode js2-mode vue-mode elm-mode helm-smex scala-mode yaml-mode rbenv inf-ruby smex evil-smartparens ruby-hash-syntax timesheet el-get json-mode markdown-mode bug-hunter helm-projectile flx-ido projectile helm evil)))
 '(pdf-loader-install nil t)
 '(pos-tip-background-color "#A6E22E")
 '(pos-tip-foreground-color "#272822")
 '(push (quote rustic-clippy) t)
 '(python-indent 4 t)
 '(ruby-align-to-stmt-keywords nil)
 '(ruby-deep-arglist nil)
 '(ruby-deep-indent-paren nil)
 '(safe-local-variable-values
   (quote
    ((eval progn
           (require
            (quote projectile))
           (setq projectile-file-exists-remote-cache-expire
                 (* 60 60))
           (setq projectile-enable-caching t)
           (setq projectile-sort-order
                 (quote recentf))
           (setq whitespace-style
                 (quote
                  (trailing)))
           (projectile-register-project-type
            (quote go)
            (quote
             ("go.mod"))
            :compilation-dir "go/" :compile "go install ./..." :src-dir "go/" :test "go test ..." :run "go test ..." :test-suffix "_test.go"))
     (eval progn
           (require
            (quote projectile))
           (setq projectile-file-exists-remote-cache-expire
                 (* 60 60))
           (setq projectile-enable-caching t)
           (setq projectile-sort-order
                 (quote recentf))
           (setq whitespace-style
                 (quote
                  (trailing)))
           (projectile-register-project-type
            (quote go)
            (quote
             ("go.mod"))
            :compile "go install ..." :test "go test ..." :run "go test ..." :test-suffix "_test.go"))
     (eval progn
           (require
            (quote projectile))
           (setq projectile-file-exists-remote-cache-expire
                 (* 60 60))
           (setq projectile-enable-caching t)
           (setq projectile-sort-order
                 (quote recentf))
           (setq whitespace-style
                 (quote
                  (trailing))))
     (eval progn
           (require
            (quote projectile))
           (setq projectile-file-exists-remote-cache-expire
                 (* 60 60))
           (setq projectile-enable-caching t)
           (setq projectile-sort-order
                 (quote recentf))
           (whitespace-mode 0))
     (eval progn
           (require
            (quote projectile))
           (setq projectile-file-exists-remote-cache-expire
                 (* 60 60))
           (setq projectile-enable-caching t)
           (setq projectile-sort-order
                 (quote recentf)))
     (projectile-sort-order quote recentf)
     (projectile-enable-caching . t)
     (projectile-file-exists-remote-cache-expire * 60 60)
     (projectile-enable-caching t)
     (projectile-file-exists-remote-cache-expire
      (* 60 60)))))
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(typescript-indent-level 2)
 '(typescript-indent-offset 2 t)
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
   (unspecified "#272822" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0"))
 '(whitespace-style (quote (trailing))))

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
 '(default ((((class color) (min-colors 89)) (:foreground "#d2cfc6" :background "#292928"))))
 '(org-block-begin-line ((t (:background "#35331D" :foreground "#75715E" :slant italic))))
 '(org-code ((t (:inherit org-block :foreground "#EEEEE"))))
 '(org-meta-line ((t (:inherit org-block-begin-line)))))

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
