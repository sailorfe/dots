;;; ui.el --- sailorfe's Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Honestly a bit miscellaneous; un-GUI Emacs and a few modes from packages.

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

(use-package which-key
  :config
  (which-key-mode))

(defun sailorfe/open-emacs-config ()
  "Open `user-emacs-directory` in Dired."
  (interactive)
  (dired user-emacs-directory))

(global-set-key (kbd "C-x c") #'sailorfe/open-emacs-config)

;; prettier dired
(use-package diredfl)

(add-hook 'dired-mode-hook #'diredfl-mode)

;; monospace eww
(add-hook 'eww-mode-hook
          (lambda ()
            (setq-local buffer-face-mode-face 'fixed-pitch)
            (buffer-face-mode t)))

;; docview
'(doc-view-continuous t)

;; vterm
(use-package vterm
  :commands vterm
  :config
  (setq vterm-shell "/bin/zsh"))

;; modeline
(use-package doom-modeline
  :init (doom-modeline-mode 1))

;; colorful-mode
(use-package colorful-mode)
(set-face-attribute 'colorful-base nil :box nil)

;; popper
(use-package popper
  :bind (("C-`"   . popper-toggle)
         ("M-`"   . popper-cycle)
         ("C-M-`" . popper-toggle-type))
  :init
  (setq popper-reference-buffers
        '("\\*Messages\\*"
          "Output\\*$"
          "\\*Async Shell Command\\*"
          "\\*vterm\\*"
          help-mode
          compilation-mode))
  (popper-mode +1)
  (popper-echo-mode +1)) ; for echo area hints

;; splash screen
(use-package dashboard
  ;; this is my own fork with truly just dashboard-navigator UI opinions: vertical layout without creating single-item lists (my old workaround) and most importantly a defcustom to replace the default square brackets around the buttons. i hesitate about publishing it because it's a bit crude and invasive to the existing code.
  :straight (dashboard
             :type git
             :host nil
             :repo "ssh://softserve/dashboard.git")
  :no-require t
  :init
  (setq dashboard-heading-shorcut-format " [%s]")
  (setq dashboard-navigator-buttons
        '(("☉" "log" "C-c a " "open org-agenda" (lambda (&rest _) (org-agenda)))
          ("☿" "dream" "C-x C-r" "recently opened files" (lambda (&rest _) (consult-recent-file)))
          ("♀" "forge" "C-x p p" "open project" (lambda (&rest _) (project-switch-project)))
          ("♂" "tinker" "C-x c " "open emacs configuration" (lambda (&rest _) (sailorfe/open-emacs-config)))
          ("♃" "revisit" "C-x r b" "jump to bookmarks" (lambda (&rest _) (bookmark-jump)))))

  (setq dashboard-startupify-list
        '(dashboard-insert-banner-title
          dashboard-insert-banner
          dashboard-insert-newline
          dashboard-insert-navigator
          dashboard-insert-newline
          dashboard-insert-init-info
          dashboard-insert-newline
          dashboard-insert-newline
          dashboard-insert-footer))

  :config
  (require 'dashboard)
  (setq banners-directory "~/.config/emacs/banners")
  (setq dashboard-startup-banner (expand-file-name "chopper.txt" banners-directory))
  (setq dashboard-center-content t)
  (setq dashboard-banner-logo-title "おかえり!")
  (setq dashboard-vertically-center-content t)
  ;; my fork
  (setq dashboard-navigator-layout 'vertical)
  (setq dashboard-navigator-shortcut-prefix "[ ")
  (setq dashboard-navigator-shortcut-suffix " ]")
  (setq dashboard-navigator-shortcut-padding 18)

  (dashboard-setup-startup-hook)
  (add-hook 'server-after-make-frame-hook (lambda () (dashboard-open))))

(provide 'ui)
;;; ui.el ends here
