;;; writing.el --- sailorfe's Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Packages for writing markdown prose.

;;; Code:
(use-package olivetti
  :hook (text-mode . olivetti-mode)
  :config
  (setq olivetti-body-width 80))

(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . gfm-mode)
  :config
  (setq markdown-fontify-code-blocks-natively t)
  (setq markdown-hide-markup t))

(use-package yaml-mode
  :ensure t)

(use-package mixed-pitch
  :ensure t
  :hook
  (markdown-mode . mixed-pitch-mode))

(provide 'writing)
;;; writing.el ends here
