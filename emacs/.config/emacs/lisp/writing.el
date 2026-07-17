;;; writing.el --- sailorfe's Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Packages for writing markdown prose.

;;; Code:
;; dictionaries
(setq ispell-program-name "hunspell"
      ispell-personal-dictionary
      (expand-file-name "emacs/hunspell"
                        (or (getenv "XDG_DATA_HOME")
                            (expand-file-name "~/.local/share"))))

;; packages
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
