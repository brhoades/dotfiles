(use-package git-link
  :ensure t
  :custom
  (defun git-clip-link () (git-link)))

(defun git-link-master ()
 (interactive)
 (setq git-link-default-branch "master")
 (apply 'git-link (append '("origin") (git-link--get-region)))
 (setq git-link-default-branch nil))


(defun git-link-main ()
 (interactive)
 (setq git-link-default-branch "main")
 (apply 'git-link (append '("origin") (git-link--get-region)))
 (setq git-link-default-branch nil))

(global-set-key (kbd "C-c p y")
                (lambda () (interactive) (apply 'git-link (append '("origin") (git-link--get-region)))))

(global-set-key (kbd "C-c p Y")
                (lambda () (git-link-master)))

(defun git-link-canonical()
 (interactive)
 (setq git-link-use-commit 't)
 (apply 'git-link (append '("origin") (git-link--get-region)))
 (setq git-link-use-commit nil))
