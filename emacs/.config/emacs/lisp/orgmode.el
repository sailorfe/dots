;;; orgmode.el --- sailorfe's Emacs configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; Simple org-mode config for managing an existing markdown system with an org folder.

;;; Code:

(use-package org
  :config
  (setq org-directory "~/d/flor/org")
  (setq org-agenda-files (directory-files-recursively org-directory "\\.org$")))

(provide 'orgmode)
;;; orgmode.el ends here
