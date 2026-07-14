;;; vcs.el --- sailorfe's Emacs configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; Version control UI.

;;; Code:

(use-package magit)

(use-package diff-hl
  :straight t
  :hook ((prog-mode . diff-hl-mode)
         (text-mode . diff-hl-mode)
         (dired-mode . diff-hl-dired-mode)
         (magit-post-refresh . diff-hl-magit-post-refresh))
  :config
  (diff-hl-margin-mode 1)
  (diff-hl-flydiff-mode 1))

(provide 'vcs)
;;; vcs.el ends here
