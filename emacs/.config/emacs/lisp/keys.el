;;; keys.el --- sailorfe's Emacs configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; Mostly evil keybindings.

;;; Code:

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
    "b b" 'switch-to-buffer
    "b n" #'next-buffer
    "b p" #'previous-buffer
    "b q" #'kill-current-buffer
    "q q" 'save-buffers-kill-terminal
    ;; dashboard
    "q l" #'desktop-read
    "o A" #'org-agenda
    "f r" #'consult-recent-file
    "p p" 'project-switch-project
    "f P" '(dired user-emacs-directory)
    "RET" #'bookmark-jump
    "h d h" #'(info "(emacs)Top")
    ;; window management
    "w h" #'evil-window-left
    "w j" #'evil-window-down
    "w k" #'evil-window-up
    "w l" #'evil-window-right
    ))


(provide 'keys)
;;; keys.el ends here
