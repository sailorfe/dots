;;; keys.el --- sailorfe's Emacs configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; Mostly evil keybindings.

;;; Code:

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-redo)
  (setq evil-want-C-d-scroll t)
  (setq evil-want-C-d-scroll t)
  (setq evil-disable-insert-state-bindings t)
  :config
  (evil-mode 1)
  :custom
  (setq evil-ex-search-case 'smart)
  (setq case-fold-search t))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(global-set-key (kbd "<escape>") #'keyboard-escape-quit)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(defun sailorfe/open-emacs-config ()
  "Open `user-emacs-directory` in Dired."
  (interactive)
  (dired user-emacs-directory))

(use-package general
  :config
  (general-create-definer sailorfe/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (sailorfe/leader-keys
    "f f" 'find-file
    "f s" 'save-buffer
    ;; buffer management
    "b b" 'consult-buffer
    "p b" 'project-switch-to-buffer
    "b q" #'kill-current-buffer
    "b k" #'kill-buffer
    "q q" 'save-buffers-kill-terminal
    ;; dashboard
    "q l" #'desktop-read
    "o A" #'org-agenda
    "f r" #'consult-recent-file
    "RET" #'bookmark-jump
    "f c" #'sailorfe/open-emacs-config
    ;; window management
    "w h" #'evil-window-left
    "w j" #'evil-window-down
    "w k" #'evil-window-up
    "w l" #'evil-window-right
    "w d" #'evil-window-delete
    ;; projects
    "p p" 'project-switch-project
    "p D" '(project-dired)
    ;; org mode
    "c c" 'org-capture
    "c s" 'org-capture-string
    "c w" 'org-refile
    ))


(provide 'keys)
;;; keys.el ends here
