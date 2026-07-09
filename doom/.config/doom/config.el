;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;(setq doom-font (font-spec :family "3270 Nerd Font"))
(setq doom-font (font-spec :family "Moralerspace Neon"))

;; indentation
(setq-default indent-tabs-mode nil
              tab-width 2)
(setq evil-shift-width 2)

;; line warpping
(setq-default truncate-lines nil)
(global-visual-line-mode +1)

;; history
(setq create-lockfiles nil)

;; navigation
(setq scroll-margin 12
      scroll-conservatively 101) ; avoid recentering jumps
;; search
(setq evil-ex-search-case 'smart)
(setq case-fold-search t)

;; ui
;; line numbers (number=true)
(setq display-line-numbers-type t)
(setq x-gtk-use-system-tooltips nil)

;; cursorline
(global-hl-line-mode +1)

;; colorcolumn
(use-package! display-fill-column-indicator
  :hook (prog-mode . display-fill-column-indicator-mode)
  :config
  (setq display-fill-column-indicator-column 80))
;; for a second ruler at 120 you'd need `whitespace-mode' with a custom
;; face, or the `fill-column-indicator' package -- no single built-in
;; supports multiple columns the way colorcolumn="80,120" does.

;; listchars equivalent (tabs/trailing/extends)
(setq whitespace-style '(face tabs trailing tab-mark))
(global-whitespace-mode -1) ; toggle on if you want it always-on like `list=true`

;; mouse support (mouse="nv")
(xterm-mouse-mode +1)

;; splitbelow/splitright
(setq evil-vsplit-window-right t
      evil-split-window-below t)

;; keybindings
;; Window navigation using leader key
(map! :leader
      (:prefix ("w" . "window")
       :n "h" #'evil-window-left
       :n "j" #'evil-window-down
       :n "k" #'evil-window-up
       :n "l" #'evil-window-right
       ;; Window resizing
       :n "H" #'evil-window-increase-width
       :n "J" #'evil-window-decrease-height
       :n "K" #'evil-window-increase-height
       :n "L" #'evil-window-decrease-width
       ))

(map! :leader
       :n "vs" #'evil-vsplit-window-right
       :n "vb" #'evil-split-window-below)

;; Terminal and Buffer management
(map! :leader
      :n "st" (cmd! (split-window-below) (+vterm/here nil))
      :n "vt" (cmd! (split-window-right) (+vterm/here nil))
      :n "bn" #'next-buffer
      :n "bp" #'previous-buffer
      :n "bq" #'kill-current-buffer)

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

(add-to-list 'custom-theme-load-path
             (expand-file-name "themes/" doom-user-dir))

(load-theme 'luna t)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
; (setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/d/flor/org")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
