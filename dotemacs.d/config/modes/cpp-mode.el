(add-hook 'c++-mode-hook
          (lambda () (setq flycheck-clang-include-path
                           (list (expand-file-name "/usr/include/SDL2/")
                                 flycheck-gcc-include-path
                                 (expand-file-name "/usr/include/Box2D/")
                                 (expand-file-name "/usr/include/GL/")
                           ))))

(setq-default flycheck-gcc-language-standard "c++21")
(setq-default c-basic-offset 2)

(add-hook 'c++-mode-hook (lambda () (setq flycheck-disabled-checkers '(c/c++-clang))))

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
