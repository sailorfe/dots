;;; orgmode.el --- sailorfe's Emacs configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; Simple org-mode config for managing an existing markdown system with an org folder.

;;; Code:

(use-package org
  :defer t
  :init
  (setq org-directory "~/d/flor/org")

  :config
  (setq org-agenda-files
        (directory-files-recursively org-directory "\\.org$"))

  (setq org-default-notes-file
        (expand-file-name "inbox.org" org-directory))

  (setq org-refile-targets
        '((org-agenda-files :maxlevel . 3)))

  (setq org-todo-keywords
        '((sequence
           "TODO(t)"
           "NEXT(n)"
           "PROG(p)"
           "WAIT(w)"
           "|"
           "DONE(d)"
           "VOID(v)")))

  (defface sailorfe-org-todo-next
    '((t (:inherit org-todo)))
    "Face for NEXT tasks."
    :group 'org-faces)

  (defface sailorfe-org-todo-prog
    '((t (:inherit org-todo)))
    "Face for PROG tasks."
    :group 'org-faces)

  (defface sailorfe-org-todo-wait
    '((t (:inherit org-todo)))
    "Face for WAIT tasks."
    :group 'org-faces)

  (defface sailorfe-org-todo-void
    '((t (:inherit org-todo)))
    "Face for VOID tasks."
    :group 'org-faces)

  (setq org-todo-keyword-faces
        '(("NEXT" . sailorfe-org-todo-next)
          ("PROG" . sailorfe-org-todo-prog)
          ("WAIT" . sailorfe-org-todo-wait)
          ("VOID" . sailorfe-org-todo-void)))
  
  (setq org-capture-templates
        '(("t" "Todo"
           entry
           (file org-default-notes-file)
           "* TODO %?\n%U\n")

          ("n" "Quick note"
           entry
           (file org-default-notes-file)
           "* %U %?\n")

         ("e" "Event"
          entry
          (file (expand-file-name "/calendar.org" org-directory))
          "* %?\nSCHEDULED: %^T\n"))))

(provide 'orgmode)
;;; orgmode.el ends here
