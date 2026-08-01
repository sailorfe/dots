;;; defaults.el --- sailorfe's Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; History and editing behavior.

;;; Code:

;; history
(let ((backup-dir (expand-file-name "emacs/backups/" (or (getenv "XDG_STATE_HOME") "~/.local/state"))))
  (unless (file-exists-p backup-dir)
    (make-directory backup-dir t))
  (setq backup-directory-alist `(("." . ,backup-dir))))

(setq create-lockfiles nil)

;; indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; line wrapping
(setq-default truncate-lines nil)
(global-visual-line-mode +1)

;; navigation
(setq-default scroll-margin 6
              scroll-conservatively 101)

;; eww
(setq browse-url-browser-function 'browse-url-eww)

(provide 'defaults)
;;; defaults.el ends here
