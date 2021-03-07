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

;(straight-use-package
; '(el-patch :type git :host github :repo "fuxialexander/org-pdftools"))

(use-package org-noter
  :ensure t
  ; :bind ("k" . nil)
  :hook (org-pdftools . org-noter))

(use-package org-roam
      :ensure t
      :hook
      (after-init . org-roam-mode)
      :custom
      (org-roam-directory "~/work/notes")
      (setq org-capture-templates '(
          '(("o" "observation about behavior" plain (function org-roam--capture-get-point)
          "%?"
          :file-name "%<%Y%m%d%H%M%S>-${slug}"
          :head "#+title: ${title}\n"
          :unnarrowed t))
          '(("O" "observation about behavior" plain (function org-roam--capture-get-point)
          "%?"
          :file-name "%<%Y%m%d%H%M%S>-${slug}"
          :head "#+title: ${title}\n"
          :unnarrowed t))
      ))

      :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n g" . org-roam-graph))
              :map org-mode-map
              (("C-c n i" . org-roam-insert))
              (("C-c n I" . org-roam-insert-immediate))))
