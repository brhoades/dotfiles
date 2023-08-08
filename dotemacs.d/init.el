(package-initialize)
;; use-package setup
(load "~/.emacs.d/config/use-package.el")

(use-package undo-tree
  :ensure t
  ; suddenly required after emacs 28
;  :bind (("C-r" . undo-tree-redo))
  :custom
    (global-undo-tree-mode t)
    (undo-tree-auto-save-history t)
    (undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo"))))

;;;;;;;;;;;;;;; Evil mode
;; Enable global evil mode early, so if something else breaks I still have arms
(use-package evil
  :after undo-tree
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-tree)
  :ensure t)
(use-package evil-smartparens
  :ensure t)
(evil-mode 1)
;;;;;;;;;;;;;;;

(setq-default indent-tabs-mode nil)
(setq tab-width 2)
(setq make-backup-files nil)

(setq tramp-default-method "ssh")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(auto-composition-mode nil t nil "Customized with use-package helm")
 '(comp-async-report-warnings-errors nil)
 '(auto-revert-remote-files t)
 '(c-basic-offset 2)
 '(c-label-minimum-indentation 2)
 '(company-idle-delay nil nil nil "Customized with use-package company")
 '(company-tooltip-align-annotations t nil nil "Customized with use-package company")
 '(compilation-message-face 'default)
 '(create-lockfiles nil)
 '(css-indent-offset 2)
 '(custom-enabled-themes '(misterioso))
 '(custom-safe-themes
   '("c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358" "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" "e9df267a1c808451735f2958730a30892d9a2ad6879fb2ae0b939a29ebf31b63" "0fffa9669425ff140ff2ae8568c7719705ef33b7a927a0ba7c5e2ffcfac09b75" "13a8eaddb003fd0d561096e11e1a91b029d3c9d64554f8e897b2513dbf14b277" "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" default))
 '(desktop-auto-save-timeout 300)
 '(desktop-restore-eager 3)
 '(desktop-save-mode t)
 '(enh-ruby-bounce-deep-indent nil)
 '(enh-ruby-deep-indent-construct nil)
 '(fci-rule-color "#3C3D37")
 '(flycheck-add-next-checker 'tsx-tide t nil "Customized with use-package flycheck")
 '(flycheck-highlighting-mode 'symbols nil nil "Customized with use-package flycheck")
 '(flymake-mode 0 t)
 '(flymake-start-on-flymake-mode nil)
 '(global-xclip-mode nil nil nil "Customized with use-package xclip")
 '(helm-ff-lynx-style-map t)
 '(helm-ff-skip-boring-files t)
 '(helm-minibuffer-history-key "M-p")
 '(helm-rg-file-paths-in-matches-behavior 'absolute)
 '(helm-rg-include-file-on-every-match-line nil)
 '(highlight-changes-colors '("#FD5FF0" "#AE81FF"))
 '(highlight-tail-colors
   '(("#3C3D37" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#3C3D37" . 100)))
 '(js-indent-level 2 nil nil "Customized with use-package json-mode")
 '(js2-strict-trailing-comma-warning nil t)
 '(lsp-flycheck-live-reporting :t)
 '(lsp-java-format-enabled nil)
 '(lsp-java-java-path "/usr/lib/jvm/java-11-openjdk/bin/java")
 '(lsp-java-save-actions-organize-imports nil)
 '(lsp-metals-java-home "/usr/lib/jvm/java-11-openjdk/")
 '(lsp-ui-flycheck-live-reporting :t t nil "Customized with use-package enh-ruby-mode")
 '(magit-diff-use-overlays nil)
 '(notmuch-search-oldest-first nil t nil "Customized with use-package notmuch")
 '(org-agenda-files '("/home/aaron/work/notes/agenda/todo.org") nil nil "Customized with use-package org")
 '(org-agenda-loop-over-headlines-in-active-region nil)
 '(org-agenda-text-search-extra-files '(agenda-archives "/home/aaron/work/notes/daily"))
 '(org-noter-always-create-frame nil)
 '(org-noter-kill-frame-at-session-end nil)
 '(org-roam-capture-templates
   '(("O" "observation about behavior" plain #'org-roam--capture-get-point "%?" :file-name "%<%Y%m%d%H%M%S>-${slug}" :head "#+title: ${title}
" :unnarrowed t)
     ("d" "default" plain #'org-roam-capture--get-point "%?" :file-name "%<%Y%m%d%H%M%S>-${slug}" :head "#+title: ${title}
" :unnarrowed t)))
 '(package-selected-packages
   '(go-projectile rg helm-lsp org org-noter org-pdfview pdf-tools evil-collection helm-notmuch notmuch helm-config protobuf-mode lsp-ui lsp-ui-sideline company-go flycheck-rust python-mode company-lsp lsp-mode nix-mode diminish use-package go-autocomplete go-imports go-mode helm-ag projectile-rails evil-magit magit rjsx-mode neotree dockerfile-mode haskell-mode purescript-mode less-css-mode flycheck-pyflakes tide exec-path-from-shell flycheck web-mode js2-mode vue-mode elm-mode helm-smex scala-mode yaml-mode rbenv smex evil-smartparens ruby-hash-syntax timesheet el-get json-mode markdown-mode bug-hunter helm-projectile flx-ido projectile helm evil))
 '(pdf-loader-install nil t nil "Customized with use-package pdf-tools")
 '(pos-tip-background-color "#A6E22E")
 '(pos-tip-foreground-color "#272822")
 '(projectile-globally-ignored-directories '("node_modules"))
 '(push 'rustic-clippy t)
 '(python-indent 4 t nil "Customized with use-package python-mode")
 '(rbenv-show-active-ruby-in-modeline nil nil nil "Customized with use-package rbenv")
 '(ruby-align-to-stmt-keywords nil)
 '(ruby-deep-arglist nil)
 '(ruby-deep-indent-paren nil)
 '(safe-local-variable-values
   '((helm-ff-avfs-directory . "~/.avfs")
     (eval progn
           (setq projectile-file-exists-remote-cache-expire
                 (* 60 60))
           (setq projectile-enable-caching t)
           (setq projectile-sort-order 'recentf)
           (setq lsp-file-watch-threshold 5000)
           (setq whitespace-style
                 '(trailing))
           (push "[/\\\\]target" lsp-file-watch-ignored)
           (push "workingdirs" lsp-file-watch-ignored)
           (push "go/replace" lsp-file-watch-ignored)
           (push "[/\\\\]\\.git" lsp-file-watch-ignored)
           (push "[/\\\\]node_modules" lsp-file-watch-ignored)
           (push "[/\\\\][^/\\\\]*\\.\\(json\\|html\\|jade\\)$" lsp-file-watch-ignored)
           (push "[/\\\\]js" lsp-file-watch-ignored)
           (push "[/\\\\]config" lsp-file-watch-ignored)
           (push "[/\\\\]sql" lsp-file-watch-ignored)
           (push "[/\\\\]proto" lsp-file-watch-ignored)
           (push "[/\\\\]migations" lsp-file-watch-ignored)
           (push "[/\\\\]secrets" lsp-file-watch-ignored)
           (push "[/\\\\]tf" lsp-file-watch-ignored)
           (push "[/\\\\]nix" lsp-file-watch-ignored)
           (push "[/\\\\]devenv" lsp-file-watch-ignored)
           (projectile-register-project-type 'go
                                             '("go.mod")
                                             :compilation-dir "go/" :compile "go install ./..." :src-dir "go/" :test "go test ..." :run "go test ..." :test-suffix "_test.go"))
     (eval progn
           (setq projectile-file-exists-remote-cache-expire
                 (* 60 60))
           (setq projectile-enable-caching t)
           (setq projectile-sort-order 'recentf)
           (setq whitespace-style
                 '(trailing))
           (push "[/\\\\]target" lsp-file-watch-ignored)
           (push "workingdirs" lsp-file-watch-ignored)
           (push "go/replace" lsp-file-watch-ignored)
           (push "[/\\\\]\\.git" lsp-file-watch-ignored)
           (push "[/\\\\]node_modules" lsp-file-watch-ignored)
           (push "[/\\\\][^/\\\\]*\\.\\(json\\|html\\|jade\\)$" lsp-file-watch-ignored)
           (push "[/\\\\]js" lsp-file-watch-ignored)
           (push "[/\\\\]config" lsp-file-watch-ignored)
           (push "[/\\\\]sql" lsp-file-watch-ignored)
           (push "[/\\\\]proto" lsp-file-watch-ignored)
           (push "[/\\\\]migations" lsp-file-watch-ignored)
           (push "[/\\\\]secrets" lsp-file-watch-ignored)
           (push "[/\\\\]tf" lsp-file-watch-ignored)
           (push "[/\\\\]nix" lsp-file-watch-ignored)
           (push "[/\\\\]devenv" lsp-file-watch-ignored)
           (projectile-register-project-type 'go
                                             '("go.mod")
                                             :compilation-dir "go/" :compile "go install ./..." :src-dir "go/" :test "go test ..." :run "go test ..." :test-suffix "_test.go"))
     (eval progn
           (require 'projectile)
           (setq projectile-file-exists-remote-cache-expire
                 (* 60 60))
           (setq projectile-enable-caching t)
           (setq projectile-sort-order 'recentf)
           (setq whitespace-style
                 '(trailing))
           (dolist
               (dir
                '("target")
                '("workingdirs"))
             (push dir lsp-file-watch-ignored))
           (projectile-register-project-type 'go
                                             '("go.mod")
                                             :compilation-dir "go/" :compile "go install ./..." :src-dir "go/" :test "go test ..." :run "go test ..." :test-suffix "_test.go"))
     (eval progn
           (require 'projectile)
           (setq projectile-file-exists-remote-cache-expire
                 (* 60 60))
           (setq projectile-enable-caching t)
           (setq projectile-sort-order 'recentf)
           (setq whitespace-style
                 '(trailing))
           (dolist
               (dir
                '("target"))
             (push dir lsp-file-watch-ignored))
           (projectile-register-project-type 'go
                                             '("go.mod")
                                             :compilation-dir "go/" :compile "go install ./..." :src-dir "go/" :test "go test ..." :run "go test ..." :test-suffix "_test.go"))
     (flycheck-eslintrc concat
                        (locate-dominating-file default-directory ".dir-locals.el")
                        "cmd/dev/.eslintrc.yaml")
     (eval progn
           (add-to-list 'exec-path
                        (concat
                         (locate-dominating-file default-directory ".dir-locals.el")
                         "cmd/dev/node_modules/.bin/")))
     (flycheck-eslintrc concat
                        (locate-dominating-file default-directory ".dir-locals.el")
                        "frontend/.eslintrc.json")
     (eval progn
           (lambda nil
             (add-to-list 'exec-path
                          (concat
                           (locate-dominating-file default-directory ".dir-locals.el")
                           "frontend/node_modules/.bin/"))
             (flycheck-eslintrc
              (concat
               (locate-dominating-file default-directory ".dir-locals.el")
               "frontend/.eslintrc.json"))))
     (eval progn
           (add-to-list 'exec-path
                        (concat
                         (locate-dominating-file default-directory ".dir-locals.el")
                         "frontend/node_modules/.bin/"))
           (flycheck-eslintrc "~/.eslintrc"))
     (eval progn
           (add-to-list 'exec-path
                        (concat
                         (locate-dominating-file default-directory ".dir-locals.el")
                         "frontend/node_modules/.bin/")))
     (eval progn
           (add-to-list 'exec-path
                        (concat
                         (locate-dominating-file default-directory ".dir-locals.el")
                         "node_modules/.bin/")))
     (eval progn
           (require 'projectile)
           (setq projectile-file-exists-remote-cache-expire
                 (* 60 60))
           (setq projectile-enable-caching t)
           (setq projectile-sort-order 'recentf)
           (setq whitespace-style
                 '(trailing))
           (projectile-register-project-type 'go
                                             '("go.mod")
                                             :compilation-dir "go/" :compile "go install ./..." :src-dir "go/" :test "go test ..." :run "go test ..." :test-suffix "_test.go"))
     (eval progn
           (require 'projectile)
           (setq projectile-file-exists-remote-cache-expire
                 (* 60 60))
           (setq projectile-enable-caching t)
           (setq projectile-sort-order 'recentf)
           (setq whitespace-style
                 '(trailing))
           (projectile-register-project-type 'go
                                             '("go.mod")
                                             :compile "go install ..." :test "go test ..." :run "go test ..." :test-suffix "_test.go"))
     (eval progn
           (require 'projectile)
           (setq projectile-file-exists-remote-cache-expire
                 (* 60 60))
           (setq projectile-enable-caching t)
           (setq projectile-sort-order 'recentf)
           (setq whitespace-style
                 '(trailing)))
     (eval progn
           (require 'projectile)
           (setq projectile-file-exists-remote-cache-expire
                 (* 60 60))
           (setq projectile-enable-caching t)
           (setq projectile-sort-order 'recentf)
           (whitespace-mode 0))
     (eval progn
           (require 'projectile)
           (setq projectile-file-exists-remote-cache-expire
                 (* 60 60))
           (setq projectile-enable-caching t)
           (setq projectile-sort-order 'recentf))
     (projectile-sort-order quote recentf)
     (projectile-enable-caching . t)
     (projectile-file-exists-remote-cache-expire * 60 60)
     (projectile-enable-caching t)
     (projectile-file-exists-remote-cache-expire
      (* 60 60))))
 '(sh-basic-offset 2)
 '(tide-format-options '(:indentSize 2 :tabSize 2 :baseIndentSize 2))
 '(tool-bar-mode nil)
 '(typescript-indent-level 2 nil nil "Customized with use-package typescript-mode")
 '(typescript-indent-offset 2 t nil "Customized with use-package typescript-mode")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   '((20 . "#F92672")
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
     (360 . "#66D9EF")))
 '(vc-annotate-very-old-color nil)
 '(web-mode-auto-quote-style 2 nil nil "Customized with use-package web-mode")
 '(web-mode-code-indent-offset 2 nil nil "Customized with use-package web-mode")
 '(web-mode-css-indent-offset 2 nil nil "Customized with use-package web-mode")
 '(web-mode-enable-auto-quoting nil nil nil "Customized with use-package web-mode")
 '(web-mode-enable-current-element-highlight t nil nil "Customized with use-package web-mode")
 '(web-mode-html-tag-font-lock-keywords
   '(("\\(</?\\)\\([[\\.:alnum:]]+\\)"
      (1 'web-mode-html-tag-bracket-face)
      (2 'web-mode-html-tag-face))
     ("\"[^\"]*\"" 0 'web-mode-html-attr-value-face)
     ("\\([[:alnum:]]+\\)" 1 'web-mode-html-attr-name-face)
     ("/?>" 0 'web-mode-html-tag-bracket-face)) t nil "Customized with use-package web-mode")
 '(web-mode-markup-indent-offset 2 nil nil "Customized with use-package web-mode")
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
 '(default ((((class color) (min-colors 89)) (:foreground "#d2cfc6" :background "#292928"))))
 '(flycheck-error ((t (:underline (:color "red" :style wave)))))
 '(org-block-begin-line ((t (:extend t :background "color-52" :foreground "color-69" :slant italic))))
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
