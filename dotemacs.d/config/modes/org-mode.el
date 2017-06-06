(require 'org)

;; Make org-mode work with files ending in .org
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-agenda-files (list "~/Documents/org/agenda/work.org"
                             "~/Documents/org/agenda/home.org"))
(global-set-key "\C-ca" 'org-agenda)
