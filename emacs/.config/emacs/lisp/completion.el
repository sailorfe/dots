;;; completion.el --- sailorfe's Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Completion/code intelligence skeleton pretty much lifted from Doom.

;;; Code:

(use-package eglot
  :ensure nil
  :hook
  ((python-mode . eglot-ensure)
   (sh-mode . eglot-ensure)
   (lisp-mode . eglot-ensure)
   (lua-mode . eglot-ensure)))

(use-package apheleia
  :config
  (apheleia-global-mode +1))

(use-package vertico
  :init
  (vertico-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic)))

(use-package marginalia
  :init
  (marginalia-mode))

(use-package consult)

(use-package corfu
  :hook (emacs-startup . global-corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-cycle t))

(use-package yasnippet
  :hook (prog-mode . yas-minor-mode))

(use-package flycheck
  :hook (prog-mode . flycheck-mode))

(add-hook 'text-mode-hook #'flyspell-mode)
(add-hook 'org-mode-hook #'flyspell-mode)
(add-hook 'markdown-mode-hook #'flyspell-mode)

(provide 'completion)
;;; completion.el ends here
