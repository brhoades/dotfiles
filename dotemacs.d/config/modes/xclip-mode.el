; X11 forwarding kill ring

(define-globalized-minor-mode global-xclip-mode xclip-mode
  (lambda () (xclip-mode 1)))

(use-package xclip
  :ensure t
  :custom
  (global-xclip-mode))
