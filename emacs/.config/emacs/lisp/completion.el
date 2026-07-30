;;; completion.el --- sailorfe's Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Completion/code intelligence skeleton pretty much lifted from Doom.

;;; Code:

;; lsp

(use-package eglot
  :ensure nil
  :hook
  ((python-mode . eglot-ensure)
   (sh-mode . eglot-ensure)
   (lisp-mode . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs '((sh-mode bash-ts-mode) . ("bash-language-server" "start")))
  )

(use-package lua-mode
  :ensure t
  :mode "\\.lua\\'"
  :hook ((lua-mode . eglot-ensure)
         (lua-ts-mode . eglot-ensure))
  :config
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
                 '(lua-mode . ("lua-language-server")))
    (add-to-list 'eglot-server-programs
                 '(lua-ts-mode . ("lua-language-server")))))

;; formatting

(use-package apheleia
  :config
  (apheleia-global-mode +1))

;; completion

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
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-cycle t))

(use-package yasnippet
  :hook (prog-mode . yas-minor-mode))

;; spellcheck / diagnostics

(use-package flycheck
  :hook (prog-mode . flycheck-mode))

(use-package jinx
  ;; requires libenchant-dev (debian) enchant2-dev (alpine)
  :hook (text-mode . jinx-mode)
  :bind (("C-;" . jinx-correct)))

(provide 'completion)
;;; completion.el ends here
