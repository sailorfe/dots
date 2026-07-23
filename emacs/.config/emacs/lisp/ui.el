;;; ui.el --- sailorfe's Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Host-based theme switching and stripping the mouse GUI wherever possible.

;;; Code:

;; un-GUI
(if (display-graphic-p)
    (progn
      (scroll-bar-mode -1)
      (tool-bar-mode -1)
      (menu-bar-mode -1)))

(setq inhibit-startup-screen t)

(setq frame-title-format "Emacs")
(setopt use-dialog-box nil)
(setopt use-short-answers t)

(global-hl-line-mode +1)

;; monospace eww
(add-hook 'eww-mode-hook
          (lambda ()
            (setq-local buffer-face-mode-face 'fixed-pitch)
            (buffer-face-mode t)))

;; in the modeline
(line-number-mode 1)
(column-number-mode 1)

;; line numbers
(use-package display-line-numbers)

(setq display-line-numbers-type t)
(global-display-line-numbers-mode 1)

(defun sailorfe/disable-line-numbers ()
  "Disable line numbers."
  (display-line-numbers-mode -1))

(add-hook 'eww-mode-hook #'sailorfe/disable-line-numbers)
(add-hook 'vterm-mode-hook #'sailorfe/disable-line-numbers)

(add-hook 'prog-mode-hook
          (lambda () (setq display-line-numbers-type 'relative)))

(add-hook 'text-mode-hook
          (lambda () (setq display-line-numbers-type t)))

;; colorcolumn
(setq-default fill-column 80)
(global-display-fill-column-indicator-mode 1)

(add-hook 'vterm-mode-hook
          (lambda () (display-fill-column-indicator-mode -1)))

;; trailing whitespace
(setq-default show-trailing-whitespace t)

;; indentation guides
(use-package indent-bars
  :hook (prog-mode . indent-bars-mode))

;; vterm
(use-package vterm
  :commands vterm
  :config
  (setq vterm-shell "/bin/zsh"))

;; font
(defun sailorfe/setup-fonts (&optional frame)
  (when (display-graphic-p frame)
    (with-selected-frame (or frame (selected-frame))
      (set-frame-font
       (pcase (system-name)
         ("thousandsunny" "Rec Mono Casual-13")
         (_               "Rec Mono Casual-11"))
       nil t)
      (dolist (font '("3270 Nerd Font" "nerd-icons"))
        (set-fontset-font t 'unicode (font-spec :family font) frame 'prepend)))))

(if (daemonp)
    (add-hook 'server-after-make-frame-hook #'sailorfe/setup-fonts)
  (sailorfe/setup-fonts))

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
             :local-repo "~/p/lua/perona.nvim"
             :repo "ssh://softserve/perona.nvim"
             :files ("extras/emacs/*.el"))
  :config
  (add-to-list 'custom-theme-load-path (straight--build-dir "perona")))

(use-package luna
  :straight (luna
             :type git
             :local-repo "~/p/lua/luna.nvim"
             :repo "ssh://softserve/luna.nvim"
             :files ("extras/emacs/*.el"))
  :config
  (add-to-list 'custom-theme-load-path (straight--build-dir "luna")))

(use-package moonqueen
  :straight (moonqueen
             :type git
             :local-repo "~/p/lua/moonqueen.nvim"
             :repo "ssh://softserve/moonqueen.nvim"
             :files ("extras/emacs/*.el"))
  :config
  (add-to-list 'custom-theme-load-path (straight--build-dir "moonqueen")))

(use-package ulti
  :straight (ulti
             :type git
             :local-repo "~/p/lisp/ulti"
             :repo "ssh://softserve/ulti")
  :config
  (add-to-list 'custom-theme-load-path (straight--build-dir "ulti")))

(load-theme
 (pcase (system-name)
   ("goingmerry" 'perona)
   ("thousandsunny"  'ulti)
   ("minimerry"  'luna)
   (_ 'moonqueen))
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

;; colorful-mode
(use-package colorful-mode)
(set-face-attribute 'colorful-base nil :box nil)

(provide 'ui)
;;; ui.el ends here
