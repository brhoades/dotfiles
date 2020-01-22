(use-package org
  :ensure t
  :defer t
  :commands (org-mode org-agenda)
  :bind ("\C-ca" . org-agenda)
  :mode "\\.org\\'"
  :custom
    (org-agenda-files (list "~/Documents/org/agenda/work.org"
	   					    "~/Documents/org/agenda/home.org")))
