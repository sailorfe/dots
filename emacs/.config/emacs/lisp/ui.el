;;; ui.el --- sailorfe's Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Host-based theme switching and stripping the mouse GUI wherever possible.

;;; Code:

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(setq frame-title-format "Emacs")
(setopt use-dialog-box nil)
(setopt use-short-answers t)

(global-hl-line-mode +1)

;; line numbers
(use-package display-line-numbers)

(setq display-line-numbers-type t)
(global-display-line-numbers-mode 1)

(add-hook 'prog-mode-hook
          (lambda () (setq display-line-numbers-type 'relative)))

(add-hook 'text-mode-hook
          (lambda () (setq display-line-numbers-type t)))

;; colorcolumn
(setq-default fill-column 80)
(global-display-fill-column-indicator-mode 1)

;; indentation guides
(use-package indent-bars
  :hook (prog-mode . indent-bars-mode))

;; vterm
(use-package vterm
  :commands vterm
  :config
  (setq vterm-shell "/bin/zsh"))

;; font
(add-to-list 'default-frame-alist '(font . "Moralerspace Neon-12"))
(dolist (font '("3270 Nerd Font" "nerd-icons"))
  (set-fontset-font "fontset-default" 'unicode (font-spec :family font) nil 'prepend))

(use-package nerd-icons
  :config
  (setq nerd-icons-scale-factor 0.8)
  (setq nerd-icons-default-adjust 0.2))

;; theme
(setq custom-theme-directory (expand-file-name "lisp/themes" user-emacs-directory))
(add-to-list 'custom-theme-load-path custom-theme-directory)

(use-package perona
  :straight (perona
             :type git
             :repo "ssh://softserve/perona.nvim"
             :files ("extras/emacs/perona-theme.el"))
  :config
  (add-to-list 'custom-theme-load-path (straight--build-dir "perona")))

(use-package ulti
  :straight (ulti
             :type git
             :repo "ssh://softserve/ulti")
  :config
  (add-to-list 'custom-theme-load-path (straight--build-dir "ulti")))

(load-theme
 (pcase (system-name)
   ("goingmerry" 'perona)
   ("thousandsunny"  'luna)
   (_ 'modus-vivendi-tinted))
 t)

;; splash screen
(use-package desktop
  :config
  (setq desktop-restore-eager 8)
  (desktop-save-mode 1))

(use-package dashboard
  :init
  (setq dashboard-heading-shorcut-format " [%s]")
  (setq dashboard-navigator-buttons
        '((( "☽" "reload session" "SPC q l" (lambda (&rest _) (desktop-read)))
           ( "☉" "org-agenda" "SPC o A" (lambda (&rest _) (org-agenda)))
           ( "☿" "recent files" "SPC f r" (lambda (&rest _) (consult-recent-file)))
           ( "♀" "open project" "SPC p p" (lambda (&rest _) (project-switch-project)))
           ( "♂" "configuration" "SPC f c" (lambda (&rest _) (sailorfe/open-emacs-config)))
           ( "♃" "bookmarks" "SPC RET" (lambda (&rest _) (bookmark-jump))))))

  (setq dashboard-startupify-list
        '(dashboard-insert-banner
          dashboard-insert-newline
          dashboard-insert-banner-title
          dashboard-insert-newline
          dashboard-insert-navigator
          dashboard-insert-newline
          dashboard-insert-init-info
          dashboard-insert-newline
          dashboard-insert-items
          dashboard-insert-newline
          dashboard-insert-footer))

  :config
  (setq dashboard-startup-banner (expand-file-name "banner.txt" user-emacs-directory))
  (setq dashboard-center-content t)
  (setq dashboard-banner-logo-title "おかえり!")
  (setq dashboard-items-default-length 5)
  (setq dashboard-show-shortcuts nil)
  (setq dashboard-items '((recents . 5)
                          (bookmarks . 5)
                          (projects . 5 )))

  (dashboard-setup-startup-hook)
  (add-hook 'server-after-make-frame-hook (lambda () (dashboard-open))))

;; modeline
(use-package doom-modeline
  :init (doom-modeline-mode 1))

(line-number-mode 1)
(column-number-mode 1)

(provide 'ui)
;;; ui.el ends here
