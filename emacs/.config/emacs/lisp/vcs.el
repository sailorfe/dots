;;; vcs.el --- sailorfe's Emacs configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; Version control UI.

;;; Code:

(use-package magit)

(use-package diff-hl
  :ensure t
  :init
  (global-diff-hl-mode 1)
  :config
  (diff-hl-margin-mode 1) ;; cut this...
  (add-hook 'find-file-hook #'diff-hl-magit-post-refresh)
  (add-hook 'after-save-hook #'diff-hl-mark-maybe-updated))

(provide 'vcs)
;;; vcs.el ends here
