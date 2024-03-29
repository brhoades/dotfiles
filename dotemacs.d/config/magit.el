(use-package magit
  :ensure t
  :defer t
  :commands (magit-mode)
  :bind (("C-x g" . magit-status)))

(use-package evil-magit
  :after (magit)
  :defer t)


; copied from git-link.el to get region
(defun git-link--get-region ()
  (save-restriction
    (widen)
    (save-excursion
      (let* ((use-region (use-region-p))
             (start (when use-region (region-beginning)))
             (end   (when use-region (region-end)))
             (line-start (line-number-at-pos start))
             line-end)
        (when use-region
          ;; Avoid adding an extra blank line to the selection.
          ;; This happens when point or mark is at the start of the next line.
          ;;
          ;; When selection is from bottom to top, exchange point and mark
          ;; so that the `point' and `(region-end)' are the same.
          (when (< (point) (mark))
            (exchange-point-and-mark))
          (when (= end (line-beginning-position))
            ;; Go up and avoid the blank line
            (setq end (1- end)))
          (setq line-end (line-number-at-pos end))
          (when (<= line-end line-start)
            (setq line-end nil)))
        (list line-start line-end)))))

