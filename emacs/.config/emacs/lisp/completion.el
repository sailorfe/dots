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

(use-package vertico
  :ensure t
  :init
  (vertico-mode))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic)))

(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))

(use-package consult
  :ensure t)

(use-package corfu
  :ensure t
  :hook (emacs-startup . global-corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-cycle t))

(use-package yasnippet
  :ensure t
  :hook (prog-mode . yas-minor-mode))

(use-package flycheck
  :ensure t
  :hook (prog-mode . flycheck-mode))

(add-hook 'text-mode-hook #'flyspell-mode)
(add-hook 'org-mode-hook #'flyspell-mode)
(add-hook 'markdown-mode-hook #'flyspell-mode)

(provide 'completion)
;;; completion.el ends here
