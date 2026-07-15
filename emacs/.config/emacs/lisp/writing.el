;;; writing.el --- sailorfe's Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Packages for writing markdown prose.

;;; Code:
(use-package olivetti
  :hook (text-mode . olivetti-mode)
  :config
  (add-hook 'olivetti-mode-hook (lambda () (setq-local olivetti-body-width 100))))

(use-package markdown-mode
  :mode ("\\.md\\'" . gfm-mode)
  :config
  (setq olivetti-style t)
  (setq markdown-fontify-code-blocks-natively t))

(provide 'writing)
;;; writing.el ends here
