;;; ui.el --- sailorfe's Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Editing visual aids, cosmetic choices.

;;; Code:

;; --- un-GUI -----------------------------------------------------------

(if (display-graphic-p)
    (progn
      (scroll-bar-mode -1)
      (tool-bar-mode -1)
      (menu-bar-mode -1)))

(setq inhibit-startup-screen t)

(setq frame-title-format "Emacs")
(setopt use-dialog-box nil)
(setopt use-short-answers t)

(use-package which-key
  :config
  (which-key-mode))

;; ======================================================================
;; in-buffer feedback
;; ======================================================================

;; indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; line wrapping
(setq-default truncate-lines nil)
(global-visual-line-mode +1)

;; navigation
(setq-default scroll-margin 6
              scroll-conservatively 101)

;; in the modeline
(line-number-mode 1)
(column-number-mode 1)

;; cursor line
(global-hl-line-mode +1)

;; trailing whitespace
(setq-default show-trailing-whitespace t)
(add-hook 'dashboard-mode-hook
          (lambda () (setq show-trailing-whitespace nil)))

;; indentation guides
(use-package indent-bars
  :hook (prog-mode . indent-bars-mode))

;; colorcolumn
(setq-default fill-column 80)
(global-display-fill-column-indicator-mode 1)

;; --- line numbers -----------------------------------------------------

(use-package display-line-numbers)
(setq display-line-numbers-type t)
(global-display-line-numbers-mode 1)

(defun sailorfe/disable-line-numbers ()
  "Disable line numbers."
  (display-line-numbers-mode -1))

;; --- mode hooks -------------------------------------------------------

(add-hook 'doc-view-mode-hook #'sailorfe/disable-line-numbers)

(add-hook 'prog-mode-hook
          (lambda () (setq display-line-numbers-type 'relative)))

(add-hook 'text-mode-hook
          (lambda () (setq display-line-numbers-type t)))

(add-hook 'eww-mode-hook
          (lambda ()
            (setq-local buffer-face-mode-face 'fixed-pitch)
            (buffer-face-mode t))
          #'sailorfe/disable-line-numbers)
;; (setq browse-url-browser-function 'browse-url-eww)

(add-hook 'vterm-mode-hook #'sailorfe/disable-line-numbers
          (lambda () (display-fill-column-indicator-mode -1)))

;; prettier dired
(use-package diredfl)
(add-hook 'dired-mode-hook #'diredfl-mode)

;; modeline
(use-package doom-modeline
  :init (doom-modeline-mode 1))

;; colorful-mode
(use-package colorful-mode)
(global-colorful-mode t)
(set-face-attribute 'colorful-base nil :box nil)

;; --- VCS sign column --------------------------------------------------

(use-package diff-hl
  ;; alpine busybox: apk add diffutils (gnu)
  :straight t
  :hook ((prog-mode . diff-hl-mode)
         (text-mode . diff-hl-mode)
         (dired-mode . diff-hl-dired-mode)
         (magit-post-refresh . diff-hl-magit-post-refresh))
  :config
  (diff-hl-margin-mode 1)
  (diff-hl-flydiff-mode 1))

;; =======================================================================
;; ⋆ ˚｡⋆ aesthetics ⋆ ˚｡⋆
;; =======================================================================

;; --- fonts -------------------------------------------------------------

(defun sailorfe/setup-fonts (&optional frame)
  "Ignore if FRAME is -nw/-tty."
  (when (display-graphic-p frame)
    (with-selected-frame (or frame (selected-frame))
      (set-frame-font
       (pcase (system-name)
         ("thousandsunny" "Rec Mono Casual-11")
         (_               "Rec Mono Casual-16"))
       nil t)
      (dolist (font '("3270 Nerd Font" "nerd-icons"))
        (set-fontset-font t 'unicode (font-spec :family font) frame 'prepend)))))

(if (daemonp)
    (add-hook 'server-after-make-frame-hook #'sailorfe/setup-fonts)
  (sailorfe/setup-fonts))

(use-package nerd-icons
  :config
  (setq nerd-icons-scale-factor 0.8)
  (setq nerd-icons-default-adjust 0.2))

;; --- themes -----------------------------------------------------------

;; locally developed
(dolist (path '("~/p/lisp/kamakura"
                "~/p/lisp/ulti"
                "~/p/lua/perona.nvim/extras/emacs"))
  (when (file-exists-p path)
    (add-to-list 'load-path path)
    (add-to-list 'custom-theme-load-path path)))

(use-package perona
  :straight nil
  :no-require t)

(use-package ulti
  :straight nil
  :no-require t)

(use-package kamakura
  :straight nil
  :no-require t)

;; "done"
(use-package luna
  :straight (luna
             :type git
             :host nil
             :repo "ssh://softserve/luna.nvim"
             :files ("extras/emacs/*.el"))
  :no-require t
  :config
  (add-to-list 'custom-theme-load-path (straight--build-dir "luna")))

(use-package moonqueen
  :straight (moonqueen
             :type git
             :host nil
             :repo "ssh://softserve/moonqueen.nvim"
             :files ("extras/emacs/*.el"))
  :no-require t
  :config
  (add-to-list 'custom-theme-load-path (straight--build-dir "moonqueen")))

(load-theme
 (pcase (system-name)
   ("northblue" 'perona)
   ("thousandsunny"  'ulti)
   ("minimerry"  'luna)
   (_ 'moonqueen))
 t)

(provide 'ui)
;;; ui.el ends here
