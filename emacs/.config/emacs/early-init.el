;;; early.init.el --- sailorfe's Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; None!

;;; Code:

;; disable package.el
(setq package-enable-at-startup nil)

;; XDG compliance
(setq user-emacs-directory (expand-file-name "~/.config/emacs/"))

;; defer GC during startup
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024)
                  gc-cons-percentage 0.1)))

;; file-name-handler-alist is consulted on every require/load for
;; TRAMP, compressed files, etc. None of that matters while loading
;; our own config, so blank it out and restore it after.
(defvar sailorfe/file-name-handler-alist-backup file-name-handler-alist)
(setq file-name-handler-alist nil)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq file-name-handler-alist sailorfe/file-name-handler-alist-backup)))

;; skip the redundant frame resize recomputation each `use-package'
;; form can trigger, and don't bother rendering menu/tool/scroll bars
;; before we explicitly turn them off in ui.el
(setq frame-inhibit-implied-resize t)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
