;;; evil.el --- sailorfe's Emacs configuration -*- lexical-binding: t;

;;; Commentary:
;; evil mode within reason

;;; Code:

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
;; trying to use C-g more!

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

(provide 'evil)
;;; evil.el ends here
