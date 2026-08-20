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

(defun sailorfe/org-timestamp-now-active ()
  (interactive)
  (org-time-stamp '(16)))

(defun sailorfe/org-timestamp-now-inactive ()
  (interactive)
  (org-time-stamp '(16) t))

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c C-/") #'sailorfe/org-timestamp-now-active)
  (define-key org-mode-map (kbd "C-c /") #'sailorfe/org-timestamp-now-inactive))

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
      `(("t" "Todo"
         entry
         (file org-default-notes-file)
         "* TODO %?\n%U\n")

        ("h" "Habit"
         entry
         (file ,(expand-file-name "personal.org" org-directory))
         (headline "routines")
         "* TODO %?\n%U\n\n:PROPERTIES:\n:STYLE: habit\n:END:")

        ("n" "Quick note"
         entry
         (file org-default-notes-file)
         "* %U %?\n")

        ("e" "Event"
         entry
         (file ,(expand-file-name "calendar.org" org-directory))
         "* %?\nSCHEDULED: %^T\n")

        ("k" "Knitting project"
         entry
         (file ,(expand-file-name "knitting.org" org-directory))
         "* PROG %?\n:PROPERTIES:\n:STARTED: %U\n:NEEDLES: \n:YARN: \n:END:")

        ("p" "Protein"
         entry
         (file+headline ,(expand-file-name "protein.org" org-directory) "daily logs")
         "* protein for day %t
| timestamp | source | protein (g) |
|-----------+--------+-------------|
|           |        |             |
|           |        |             |
|-----------+--------+-------------|
| total     |        |             |
#+TBLFM: @>$3 = vsum(@I..@-1)"
         )))


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
