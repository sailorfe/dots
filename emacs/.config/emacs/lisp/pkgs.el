;;; pkgs.el --- sailorfe's Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; this needs severe organization lol

;;; Code:

;; repos
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(package-initialize)

;; bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; packages
(use-package no-littering
  :config
  (setq auto-save-file-name-transforms
        `((".*" ,(no-littering-expand-var-file-name "auto-save/") t))))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))


(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; lsp
(use-package eglot
  :ensure nil
  :hook
  ((python-mode . eglot-ensure)
   (sh-mode . eglot-ensure)
   (lisp-mode . eglot-ensure)))

;; splash screen
(use-package desktop
  :config
  (desktop-save-mode 1))

(use-package dashboard
  :ensure t
  :init
  (setq dashboard-heading-shorcut-format " [%s]")
  (setq dashboard-navigator-buttons
      '((( "☽" "reload session" "SPC q l" (lambda (&rest _) (desktop-read)))
         ( "☉" "org-agenda"     "SPC o A" (lambda (&rest _) (org-agenda)))
         ( "☿" "recent files"   "SPC f r" (lambda (&rest _) (consult-recent-file)))
         ( "♀" "open project"   "SPC p p" (lambda (&rest _) (project-switch-project)))
        ( "♂" "configuration"  "SPC f P" (lambda (&rest _) (dired user-emacs-directory)))
         ( "♃" "bookmarks"      "SPC RET" (lambda (&rest _) (bookmark-jump)))
         ( "♄" "documentation"  "SPC h d h" (lambda (&rest _) (info "(emacs)Top"))))))

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
  (setq dashboard-vertically-center-content t)
  (setq dashboard-banner-logo-title "おかえり!")
 
  (dashboard-setup-startup-hook))

(provide 'pkgs)
