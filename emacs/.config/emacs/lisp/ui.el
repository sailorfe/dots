;;; ui.el --- sailorfe's Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Host-based theme switching and stripping the mouse GUI wherever possible.

;;; Code:

;; font
(set-face-attribute 'default nil :font "Moralerspace Neon-14")

;; theme
(setq custom-theme-directory (expand-file-name "lisp/themes" user-emacs-directory))
(add-to-list 'custom-theme-load-path custom-theme-directory)

(let ((theme-var (getenv "THEME")))
  (if theme-var
      (load-theme (intern theme-var) t)
    (load-theme 'modus-operandi t)))

;; basic ui
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(setq frame-title-format "Emacs")
(setopt use-dialog-box nil)
(setopt use-short-answers t)

(provide 'ui)
;;; ui.el ends here
