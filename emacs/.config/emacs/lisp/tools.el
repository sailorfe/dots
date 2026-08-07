;;; tools.el --- sailorfe's Emacs configuration -*- lexical-binding: t;  -*-

;;; Commentary:
;; external packages with a bit more config and QoL extensions, commands

;;; Code:

;;; --- external packages ----------------------------------------------

;; vterm
(use-package vterm
  :commands vterm
  :config
  (setq vterm-shell "/bin/zsh"))

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
  ;; this is my own fork with truly just dashboard-navigator UI opinions:
  ;;
  ;; - vertical layout without creating single-item lists (my old workaround)
  ;; - defcustom to replace the default square brackets around the buttons
  :straight (dashboard
             :type git
             :host nil
             :repo "ssh://softserve/dashboard.git")
  :no-require t
  :init
  (setq dashboard-heading-shorcut-format " [%s]")
  (setq dashboard-navigator-buttons
        '(("☉" "log"        " C-c a " "open org-agenda" (lambda (&rest _) (org-agenda)))
          ("☿" "dream"      "C-x C-r" "recently opened files" (lambda (&rest _) (consult-recent-file)))
          ("♀" "forge"      "C-x p p" "open project" (lambda (&rest _) (project-switch-project)))
          ("♂" "tinker"     " C-x c " "open emacs configuration" (lambda (&rest _) (sailorfe/open-emacs-config)))
          ("♃" "return"     "C-x r b" "jump to bookmarks" (lambda (&rest _) (bookmark-jump)))))

  (setq dashboard-startupify-list
        '(dashboard-insert-banner-title
          dashboard-insert-banner
          dashboard-insert-newline
          dashboard-insert-init-info
          dashboard-insert-newline
          dashboard-insert-newline
          dashboard-insert-navigator
          dashboard-insert-newline
          ;; dashboard-insert-items
          dashboard-insert-newline
          dashboard-insert-footer))

  :config
  (require 'dashboard)
  (setq banners-directory "~/.config/emacs/banners")
  (setq dashboard-startup-banner (expand-file-name "chopper.txt" banners-directory))
  (setq dashboard-center-content t)
  (setq dashboard-banner-logo-title "おかえり!")
  (setq dashboard-vertically-center-content t)
  (setq dashboard-show-shortcuts nil)
  ;; (setq dashboard-items '((recents . 5) (projects . 5) (bookmarks . 5) (agenda . 5)))
  ;; my fork
  (setq dashboard-navigator-layout 'vertical)
  (setq dashboard-navigator-shortcut-prefix "[ ")
  (setq dashboard-navigator-shortcut-suffix " ]")
  (setq dashboard-navigator-shortcut-padding 18)

  (dashboard-setup-startup-hook)
  (add-hook 'server-after-make-frame-hook (lambda () (dashboard-open))))

;; --- custom commands --------------------------------------------------

(defun sailorfe/open-emacs-config ()
  "Open `user-emacs-directory` in Dired."
  (interactive)
  (dired user-emacs-directory))

(global-set-key (kbd "C-x c") #'sailorfe/open-emacs-config)

;; vterm project viewer
(use-package project
  :bind
  (:map project-prefix-map
        ("t" . sailorfe/project-vterm))
  :config
  (defun sailorfe/project-vterm ()
    (interactive)
    (let ((default-directory (project-root (project-current t))))
      (vterm))))

(with-eval-after-load 'project
  (add-to-list 'project-switch-commands
               '(sailorfe/project-vterm "vterm" ?t)
               t))


(provide 'tools)
;;; tools.el ends here
