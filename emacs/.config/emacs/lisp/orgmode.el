;;; orgmode.el --- sailorfe's Emacs configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; Simple org-mode config for managing an existing markdown system with an org folder.

;;; Code:
(use-package org
  :straight (:type built-in)
  :defer t
  :init
  (setq org-directory "~/d/org")

  :config
  (setq org-agenda-files (list org-directory))

  (setq org-default-notes-file
        (expand-file-name "inbox.org" org-directory))

  (setq org-refile-targets
        '((org-agenda-files :maxlevel . 3))))

;; keybindings
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

(setq org-log-done 'time)

(setq org-startup-indented t)

(setq org-hide-emphasis-markers t)

(setq org-agenda-start-on-weekday 1)

(setq org-log-into-drawer t)

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

        ("h" "Habit"
         entry
         (file org-default-notes-file)
         "* TODO %?\n%U\n\n:PROPERTIES:\n:STYLE: habit\n:END:")

        ("n" "Quick note"
         entry
         (file org-default-notes-file)
         "* %U %?\n")

        ("e" "Event"
         entry
         (file org-default-notes-file)
         "* %?\nSCHEDULED: %^T\n")

        ("k" "Knitting project"
         entry
         (file org-default-notes-file)
         "* PROG %?\n:PROPERTIES:\n:STARTED: %U\n:NEEDLES: \n:YARN: \n:END:")))


(org-babel-do-load-languages
 'org-babel-load-languages '(
                             (C . t)
                             (python . t)
                             (shell . t)
                             (emacs-lisp . t)
                             (lua . t)
                             )
 )

(provide 'orgmode)
;;; orgmode.el ends here
