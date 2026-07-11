;;; init.el --- sailorfe's Emacs configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; A launcher for everything under lisp/.

;;; Code:

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'defaults)
(require 'bootstrap)
(require 'completion)
(require 'keys)
(require 'ui)
(require 'vcs)
(require 'orgmode)
(require 'writing)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; init.el ends here
