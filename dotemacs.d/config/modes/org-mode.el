(use-package org
  :ensure t
  :bind ("\C-ca" . org-agenda)
  :mode "\\.org\\'"
  :custom
    (org-agenda-files (list "~/Documents/org/agenda/work.org"
	   					    "~/Documents/org/agenda/home.org"))
    (add-to-list 'org-file-apps
                 '("\\.pdf\\'" . (lambda (file link)
                                   (org-pdfview-open link)))))

(straight-use-package
 '(el-patch :type git :host github :repo "fuxialexander/org-pdftools"))

(use-package org-noter
  :ensure t
  ; :bind ("k" . nil)
  :hook (org-pdftools . org-noter))
