;;; init.el --- sailorfe's Emacs configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; A launcher for everything under lisp/.

;;; Code:

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'core)
(require 'pkgs)
(require 'completion)
(require 'ui)
(require 'keys)
(require 'orgmode)
(require 'writing)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(consult corfu dashboard evil flycheck general marginalia
             markdown-mode mixed-pitch nerd-icons no-littering
             olivetti orderless vertico yaml-mode yasnippet)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; init.el ends here
