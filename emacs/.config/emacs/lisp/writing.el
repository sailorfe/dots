;;; writing.el --- sailorfe's Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Packages for writing prose.

;;; Code:
(use-package olivetti
  :hook (text-mode . olivetti-mode)
  :config
  (add-hook 'olivetti-mode-hook (lambda () (setq-local olivetti-body-width 100))))

(defun ensure-visual-line-mode-after-olivetti ()
  "Ensure visual-line-mode is enabled if olivetti-mode is turned off."
  (unless olivetti-mode
    (visual-line-mode 1)))

(add-hook 'olivetti-mode-hook 'ensure-visual-line-mode-after-olivetti)

(use-package markdown-mode
  :mode ("\\.md\\'" . gfm-mode)
  :config
  (setq markdown-fontify-code-blocks-natively t))

(use-package pdf-tools
  :defer t
  :config
  (pdf-loader-install)
  (add-hook 'pdf-view-mode-hook #'pdf-view-roll-minor-mode))

(add-to-list 'auto-mode-alist '("\\.pdf\\'" . pdf-view-mode))

(provide 'writing)
;;; writing.el ends here
