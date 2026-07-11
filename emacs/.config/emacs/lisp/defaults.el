;;; defaults.el

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

;; clipboard
;setq select-enable-clipboard t)
;setq select-enable-primary t)

;when (executable-find "wl-copy")
; (setq interprogram-cut-function
;       (lambda (text)
;         (let ((process-connection-type nil))
;           (let ((proc (start-process "wl-copy" "*wl-copy" "wl-copy" "-n")))
;             (process-send-string proc text)
;             (process-send-eof proc)))))
; (setq interprogram-paste-function
;       (lambda ()
;         (let ((process-connection-type nil))
;            (shell-command-to-string "wl-paste -n")))))
            

(provide 'defaults)
;;; defaults.el ends here
