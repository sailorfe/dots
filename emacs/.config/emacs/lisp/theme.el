;;; theme.el --- sailorfe's Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Host-based theme and font switching.

;;; Code:

;; font
(defun sailorfe/setup-fonts (&optional frame)
  "Ignore if FRAME is -nw/-tty."
  (when (display-graphic-p frame)
    (with-selected-frame (or frame (selected-frame))
      (set-frame-font
       (pcase (system-name)
         ("thousandsunny" "Rec Mono Casual-13")
         (_               "Rec Mono Casual-10"))
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

;; theme
(setq custom-theme-directory (expand-file-name "lisp/themes" user-emacs-directory))
(add-to-list 'custom-theme-load-path custom-theme-directory)

(use-package perona
  :straight (perona
             :type git
             :host nil
             :repo "ssh://softserve/perona.nvim"
             :files ("extras/emacs/*.el"))
  :no-require t
  :config
  (add-to-list 'custom-theme-load-path (straight--build-dir "perona")))

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

(use-package ulti
  :straight (ulti
             :type git
             :host codeberg
             :repo "sailorfe/ulti")
  :no-require t
  :config
  (add-to-list 'custom-theme-load-path (straight--build-dir "ulti")))

(use-package kamakura
  :straight (kamakura
             :type git
             :local-repo "~/p/lisp/kamakura")
  :no-require t
  :config
  (add-to-list 'custom-theme-load-path "~/p/lisp/kamakura"))

(load-theme
 (pcase (system-name)
   ("northblue" 'perona)
   ("thousandsunny"  'ulti)
   ("minimerry"  'luna)
   (_ 'moonqueen))
 t)

(provide 'theme)
;;; theme.el ends here
