(setq package-list 
                  '(helm-ag flycheck-rust rust-mode projectile-rails evil-magit magit rjsx-mode neotree dockerfile-mode jsx-mode haskell-mode purescript-mode less-css-mode flycheck-pyflakes tide exec-path-from-shell flycheck web-mode js2-mode vue-mode elm-mode helm-smex scala-mode yaml-mode rbenv inf-ruby smex evil-smartparens ruby-hash-syntax timesheet el-get jedi json-mode markdown-mode bug-hunter helm-projectile flx-ido projectile helm evil))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))
    :qa




