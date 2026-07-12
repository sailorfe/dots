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
