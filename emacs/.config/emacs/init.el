;;; init.el --- sailorfe's Emacs configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; A launcher for everything under lisp/.

;;; Code:

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'bootstrap)
(require 'defaults)
(require 'completion)
(require 'keys)
(require 'ui)
(require 'vcs)
(require 'orgmode)
(require 'writing)

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   '("/home/sailorfe/d/flor/org/calendar.org"
     "/home/sailorfe/d/flor/org/inbox.org"
     "/home/sailorfe/d/flor/org/knitting.org"
     "/home/sailorfe/d/flor/org/media.org"
     "/home/sailorfe/d/flor/org/personal.org"
     "/home/sailorfe/d/flor/org/projects.org"
     "/home/sailorfe/d/flor/org/shopping.org")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
