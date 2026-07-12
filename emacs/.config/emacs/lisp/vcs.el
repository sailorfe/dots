;;; vcs.el --- sailorfe's Emacs configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; Versin control UI.

;;; Code:

(use-package magit)

;; gitsigns
(use-package diff-hl
  :hook ((prog-mode . diff-hl-mode)
         (org-mode . diff-hl-mode)
         (dired-mode . diff-hl-mode)
         (text-mode . diff-hl-mode))
  :config
  (diff-hl-margin-mode 1)
  (diff-hl-flydiff-mode 1))

(provide 'vcs)
;;; vcs.el ends here
