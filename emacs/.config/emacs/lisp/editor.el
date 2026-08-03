;;; editor.el --- sailorfe's Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Editing behavior.

;;; Code:

;; history
(let ((backup-dir (expand-file-name "emacs/backups/" (or (getenv "XDG_STATE_HOME") "~/.local/state"))))
  (unless (file-exists-p backup-dir)
    (make-directory backup-dir t))
  (setq backup-directory-alist `(("." . ,backup-dir))))

(setq create-lockfiles nil)

;; persistence
(use-package desktop
  :config
  (setq desktop-restore-eager 8)
  (desktop-save-mode 1))

;; evil mode
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-redo)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-d-scroll t)
  (setq evil-disable-insert-state-bindings t)
  :config
  (evil-mode 1)
  :custom
  (setq evil-ex-search-case 'smart)
  (setq case-fold-search t))

;; (global-set-key (kbd "<escape>") #'keyboard-escape-quit)

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

;; buffer management
(global-set-key (kbd "C-x k") 'kill-current-buffer) ; remapped from 'kill-buffer which sucks imo
(global-set-key (kbd "C-x K") 'kill-buffer) ; because i never use this

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

;; in the modeline
(line-number-mode 1)
(column-number-mode 1)

;; highlight
(global-hl-line-mode +1)

;; line numbers
(use-package display-line-numbers)

(setq display-line-numbers-type t)
(global-display-line-numbers-mode 1)

(defun sailorfe/disable-line-numbers ()
  "Disable line numbers."
  (display-line-numbers-mode -1))

(add-hook 'eww-mode-hook #'sailorfe/disable-line-numbers)
(add-hook 'vterm-mode-hook #'sailorfe/disable-line-numbers)
(add-hook 'doc-view-mode-hook #'sailorfe/disable-line-numbers)

(add-hook 'prog-mode-hook
          (lambda () (setq display-line-numbers-type 'relative)))

(add-hook 'text-mode-hook
          (lambda () (setq display-line-numbers-type t)))

;; vcs sign column
(use-package diff-hl
  ;; alpine busybox: apk add diffutils (gnu)
  :straight t
  :hook ((prog-mode . diff-hl-mode)
         (text-mode . diff-hl-mode)
         (dired-mode . diff-hl-dired-mode)
         (magit-post-refresh . diff-hl-magit-post-refresh))
  :config
  (diff-hl-margin-mode 1)
  (diff-hl-flydiff-mode 1))

;; colorcolumn
(setq-default fill-column 80)
(global-display-fill-column-indicator-mode 1)

(add-hook 'vterm-mode-hook
          (lambda () (display-fill-column-indicator-mode -1)))

;; trailing whitespace
(setq-default show-trailing-whitespace t)

(add-hook 'dashboard-mode-hook
          (lambda () (setq show-trailing-whitespace nil)))

;; indentation guides
(use-package indent-bars
  :hook (prog-mode . indent-bars-mode))

(provide 'editor)
;;; editor.el ends here
