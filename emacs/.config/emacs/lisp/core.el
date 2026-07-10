;;; core.el

;;; Commentary:
;; History and file wrangling.

;;; Code:

;;; history
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
(setq-default scroll-margin 12
              scroll-conservatively 101)

;; search
(setq evil-ex-search-case 'smart)
(setq case-fold-search t)


(provide 'core)
;;; core.el ends here
