(use-package notmuch
  :ensure t
  :defer
  :commands (notmuch notmuch-hello)
  :hook ((notmuch-hello . evil-normal-state) ; try to make evil mode work
         (notmuch-hello . evil-collection-notmuch-setup)
         (notmuch-hello-refresh . evil-collection-notmuch-setup)
         (notmuch-tree-command . evil-collection-notmuch-setup)
         (notmuch-search . evil-collection-notmuch-setup)))
