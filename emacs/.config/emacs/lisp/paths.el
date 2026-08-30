;;; paths.el --- sailorfe's Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; XDG compliance and file wrangling.

;;; Code:

;; xdg
(defconst emacs-config-dir
  (expand-file-name "emacs/"
                    (or (getenv "XDG_CONFIG_HOME")
                        "~/.config/")))

(defconst emacs-state-dir
  (expand-file-name "emacs/"
                    (or (getenv "XDG_STATE_HOME")
                        "~/.local/state/")))

(defconst emacs-cache-dir
  (expand-file-name "emacs/"
                    (or (getenv "XDG_CACHE_HOME")
                        "~/.local/cache/")))

(defconst emacs-data-dir
  (expand-file-name "emacs/"
                    (or (getenv "XDG_DATA_HOME")
                        "~/.local/share/")))

(make-directory emacs-state-dir t)
(make-directory emacs-cache-dir t)
(make-directory emacs-data-dir t)

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
      (expand-file-name "auto-save/sessions-" emacs-state-dir))

;; don't create .#foo lock files
(setq create-lockfiles nil)

;; persistent state
(setq bookmark-default-file
      (expand-file-name "bookmarks.el" emacs-state-dir)
      project-list-file
      (expand-file-name "projects.el" emacs-state-dir)
      recentf-save-file
      (expand-file-name "recentf.el" emacs-state-dir))

;; read changes from disk faster
(global-auto-revert-mode 1)

(setq auto-revert-verbose nil
      auto-revert-check-vc-info t
      auto-revert-interval 1)

;; persistence
(use-package desktop
  :custom
  (desktop-path (list emacs-state-dir))
  (desktop-dirname emacs-state-dir)
  (desktop-base-file-name "desktop.el")
  (desktop-restore-eager 8)
  :config
  (desktop-save-mode 1))

;; SHELL PATH
(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

(provide 'paths)
;;; paths.el ends here
