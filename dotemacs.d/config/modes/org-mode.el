(use-package org
  :ensure t
  :defer t
  :bind ("\C-ca" . org-agenda)
  :mode ("\\.org$" . org-mode)
  :hook (org . (visual-line-mode))
  :custom
    (org-agenda-files (list "~/Documents/org/agenda/work.org"
	   					    "~/Documents/org/agenda/home.org"))
    (org-adapt-indentation nil)
    (add-to-list 'org-file-apps
                 '("\\.pdf\\'" . (lambda (file link)
                                   (org-pdfview-open link)))))

(straight-use-package
 '(el-patch :type git :host github :repo "fuxialexander/org-pdftools"))

(use-package org-noter
  :ensure t
  ; :bind ("k" . nil)
  :hook (org-pdftools . org-noter))
