;;; state.el --- sailorfe's Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; State, history management.

;;; Code:

;; xdg my lover
(defvar emacs-state-dir
  (expand-file-name
   "emacs/"
   (or (getenv "XDG_STATE_HOME")
       "~/.local/state/")))

(make-directory emacs-state-dir t)

;; backups
(let ((dir (expand-file-name "backups/" emacs-state-dir)))
  (make-directory dir t)
  (setq backup-directory-alist `(("." . ,dir))))

;; auto-save
(let ((dir (expand-file-name "auto-save/" emacs-state-dir)))
  (make-directory dir t)
  (setq auto-save-file-name-transforms
        `((".*" ,dir t))))

(setq auto-save-list-file-prefix
      (expand-file-name "auto-save/sessions" emacs-state-dir))

;; persistence
(setq bookmark-default-file (expand-file-name "bookmark-default.el" emacs-state-dir)
      project-list-file     (expand-file-name "project-list.el" emacs-state-dir)
      recentf-save-file     (expand-file-name "recentf-save.el" emacs-state-dir))

(use-package desktop
  :custom
  (desktop-path (list emacs-state-dir))
  (desktop-dirname emacs-state-dir)
  (desktop-base-file-name "desktop.el")
  (desktop-restore-eager 8)
  :config
  (desktop-save-mode 1))

(provide 'state)
;;; state.el ends here
