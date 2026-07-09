;;; perona-theme.el --- A bubblegum goth pirate theme -*- lexical-binding: t; -*-

;; Author: sailorfe
;; URL: https://codeberg.org/sailorfe/perona.nvim
;; Package-Requires: ((emacs "30.1"))
;; Version: 0.1.0

;;; Commentary:
;; Port of perona.nvim.

;;; Code:

(deftheme perona
  "Bubblegum goth pirate theme.")

(let ((base    "#261720")   ; darkest background
      (surface "#331f2b")   ; slightly raised background
      (overlay "#3f2735")   ; selections, popups
      (text    "#eac3da")   ; main foreground
      (light   "#ffebf7")   ; brightest foreground, used on strong bg
      (mihawk  "#d0435f")   ; red - errors, deletions
      (garden  "#d18de2")   ; lavender - types, additions, ok
      (sangria "#e28d8d")   ; coral - warnings, strings/constants
      (kumashi "#8dafe2")   ; blue - keywords, info, links
      (zombie  "#d65c8d")   ; magenta - identifiers, special
      (hollow  "#ed82c2")   ; bubblegum pink - functions, titles, hints
      (low     "#31212a")   ; folds
      (med     "#48323f")   ; search bg, header-line bg
      (high    "#5f4554")   ; strong emphasis bg
      (faint   "#ad859d")   ; comments, dimmed text
      (muted   "#896c7d"))  ; line numbers, very dimmed text

  (custom-theme-set-faces
   'perona

   ;; --- core ui -------------------------------------------------
   `(default ((t (:background ,base :foreground ,text))))
   `(cursor ((t (:background ,text))))
   `(region ((t (:background ,hollow :foreground ,base))))
   `(secondary-selection ((t (:background ,med :foreground ,sangria))))
   `(highlight ((t (:background ,overlay :foreground ,hollow))))
   `(hl-line ((t (:background ,overlay))))
   `(fringe ((t (:background ,base :foreground ,muted))))
   `(vertical-border ((t (:foreground ,surface))))
   `(window-divider ((t (:foreground ,surface))))
   `(window-divider-first-pixel ((t (:foreground ,surface))))
   `(window-divider-last-pixel ((t (:foreground ,surface))))
   `(minibuffer-prompt ((t (:foreground ,kumashi :weight bold))))
   `(shadow ((t (:foreground ,muted))))
   `(link ((t (:foreground ,kumashi :underline t))))
   `(link-visited ((t (:foreground ,garden :underline t))))
   `(escape-glyph ((t (:foreground ,zombie))))
   `(homoglyph ((t (:foreground ,zombie))))
   `(tooltip ((t (:background ,surface :foreground ,text))))
   `(trailing-whitespace ((t (:background ,overlay))))
   `(nobreak-space ((t (:foreground ,muted :underline t))))

   ;; --- errors / warnings / success ------------------------------
   `(error ((t (:foreground ,mihawk :weight bold))))
   `(warning ((t (:foreground ,sangria :weight bold))))
   `(success ((t (:foreground ,garden :weight bold))))

   ;; --- mode-line / header / tab lines ---------------------------
   `(mode-line ((t (:background ,overlay :foreground ,text))))
   `(mode-line-inactive ((t (:background ,surface :foreground ,muted))))
   `(mode-line-active ((t (:background ,overlay :foreground ,text))))
   `(mode-line-emphasis ((t (:foreground ,hollow :weight bold))))
   `(mode-line-highlight ((t (:foreground ,hollow :box (:line-width -1 :color ,hollow)))))
   `(mode-line-buffer-id ((t (:foreground ,text :weight bold))))
   `(header-line ((t (:background ,med :foreground ,faint))))
   `(header-line-highlight ((t (:background ,med :foreground ,hollow))))
   `(tab-line ((t (:background ,surface :foreground ,muted))))
   `(tab-line-tab ((t (:background ,surface :foreground ,muted))))
   `(tab-line-tab-inactive ((t (:background ,surface :foreground ,muted))))
   `(tab-line-tab-current ((t (:background ,overlay :foreground ,hollow :weight bold))))
   `(tab-line-highlight ((t (:background ,overlay :foreground ,hollow))))
   `(tab-bar ((t (:background ,surface :foreground ,muted))))
   `(tab-bar-tab ((t (:background ,overlay :foreground ,hollow :weight bold))))
   `(tab-bar-tab-inactive ((t (:background ,surface :foreground ,muted))))

   ;; --- line numbers ----------------------------------------------
   `(line-number ((t (:foreground ,muted :background ,base))))
   `(line-number-current-line ((t (:foreground ,text :background ,overlay :weight bold))))
   `(line-number-major-tick ((t (:foreground ,faint :background ,base))))
   `(line-number-minor-tick ((t (:foreground ,muted :background ,base))))

   ;; --- search / isearch --------------------------------------------
   `(isearch ((t (:background ,sangria :foreground ,base))))
   `(isearch-fail ((t (:background ,mihawk :foreground ,light))))
   `(isearch-group-1 ((t (:background ,kumashi :foreground ,base))))
   `(isearch-group-2 ((t (:background ,garden :foreground ,base))))
   `(lazy-highlight ((t (:background ,med :foreground ,sangria))))
   `(query-replace ((t (:background ,sangria :foreground ,base))))

   ;; --- show-paren --------------------------------------------------
   `(show-paren-match ((t (:background ,high :weight bold))))
   `(show-paren-match-expression ((t (:background ,overlay))))
   `(show-paren-mismatch ((t (:background ,mihawk :foreground ,light :weight bold))))

   ;; --- font-lock (syntax highlighting) -------------------------------
   `(font-lock-comment-face ((t (:foreground ,faint :slant italic))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,faint :slant italic))))
   `(font-lock-doc-face ((t (:foreground ,faint :slant italic))))
   `(font-lock-doc-markup-face ((t (:foreground ,faint))))
   `(font-lock-string-face ((t (:foreground ,sangria))))
   `(font-lock-keyword-face ((t (:foreground ,kumashi :weight bold))))
   `(font-lock-builtin-face ((t (:foreground ,zombie :weight bold :slant italic))))
   `(font-lock-function-name-face ((t (:foreground ,hollow))))
   `(font-lock-function-call-face ((t (:foreground ,hollow))))
   `(font-lock-variable-name-face ((t (:foreground ,text :slant italic))))
   `(font-lock-variable-use-face ((t (:foreground ,text))))
   `(font-lock-type-face ((t (:foreground ,garden))))
   `(font-lock-constant-face ((t (:foreground ,sangria))))
   `(font-lock-warning-face ((t (:foreground ,sangria :weight bold))))
   `(font-lock-negation-char-face ((t (:foreground ,mihawk :weight bold))))
   `(font-lock-preprocessor-face ((t (:foreground ,kumashi))))
   `(font-lock-regexp-grouping-backslash ((t (:foreground ,zombie :weight bold))))
   `(font-lock-regexp-grouping-construct ((t (:foreground ,zombie :weight bold))))
   `(font-lock-property-name-face ((t (:foreground ,text))))
   `(font-lock-property-use-face ((t (:foreground ,text))))
   `(font-lock-number-face ((t (:foreground ,sangria))))
   `(font-lock-operator-face ((t (:foreground ,text))))
   `(font-lock-bracket-face ((t (:foreground ,text))))
   `(font-lock-delimiter-face ((t (:foreground ,muted))))
   `(font-lock-punctuation-face ((t (:foreground ,text))))
   `(font-lock-escape-face ((t (:foreground ,hollow))))

   ;; --- diff-mode ------------------------------------------------
   `(diff-header ((t (:background ,surface))))
   `(diff-file-header ((t (:background ,surface :foreground ,text :weight bold))))
   `(diff-hunk-header ((t (:background ,surface :foreground ,muted))))
   `(diff-context ((t (:foreground ,faint))))
   `(diff-added ((t (:foreground ,garden))))
   `(diff-removed ((t (:foreground ,mihawk))))
   `(diff-changed ((t (:foreground ,hollow))))
   `(diff-refine-added ((t (:background ,garden :foreground ,base))))
   `(diff-refine-removed ((t (:background ,mihawk :foreground ,light))))
   `(diff-refine-changed ((t (:background ,hollow :foreground ,base))))
   `(diff-indicator-added ((t (:foreground ,garden))))
   `(diff-indicator-removed ((t (:foreground ,mihawk))))
   `(diff-indicator-changed ((t (:foreground ,hollow))))

   ;; --- flyspell ---------------------------------------------------
   `(flyspell-incorrect ((t (:foreground ,mihawk :underline (:style wave)))))
   `(flyspell-duplicate ((t (:foreground ,sangria :underline (:style wave)))))

   ;; --- completions (in-buffer / *Completions*) ---------------------
   `(completions-common-part ((t (:foreground ,hollow :weight bold))))
   `(completions-first-difference ((t (:foreground ,zombie :weight bold))))
   `(completions-annotations ((t (:foreground ,muted :slant italic))))
   `(completions-group-title ((t (:foreground ,faint :weight bold))))

   ;; --- widgets / custom-mode ----------------------------------------
   `(widget-field ((t (:background ,overlay :foreground ,text :box (:line-width 1 :color ,muted)))))
   `(widget-single-line-field ((t (:background ,overlay :foreground ,text))))
   `(widget-button ((t (:foreground ,hollow :weight bold))))
   `(widget-documentation ((t (:foreground ,faint))))
   `(custom-button ((t (:background ,surface :foreground ,text :box (:line-width 1 :color ,muted)))))
   `(custom-button-mouse ((t (:background ,overlay :foreground ,hollow :box (:line-width 1 :color ,hollow)))))
   `(custom-button-pressed ((t (:background ,overlay :foreground ,hollow :box (:line-width 1 :color ,hollow)))))
   `(custom-state ((t (:foreground ,garden))))
   `(custom-variable-tag ((t (:foreground ,hollow :weight bold))))
   `(custom-group-tag ((t (:foreground ,kumashi :weight bold))))

   ;; --- misc buffer / dired -----------------------------------------
   `(match ((t (:background ,med :foreground ,sangria))))
   `(next-error ((t (:background ,overlay))))
   `(help-key-binding ((t (:foreground ,hollow :background ,surface :box (:line-width 1 :color ,muted)))))
   `(dired-directory ((t (:foreground ,kumashi))))
   `(dired-symlink ((t (:foreground ,zombie))))
   `(dired-broken-symlink ((t (:foreground ,mihawk :underline t))))
   `(dired-marked ((t (:foreground ,hollow :weight bold))))
   `(dired-flagged ((t (:foreground ,mihawk :weight bold))))
   `(dired-header ((t (:foreground ,hollow :weight bold))))
   `(dired-ignored ((t (:foreground ,muted))))
   `(dired-mark ((t (:foreground ,hollow :weight bold))))
   `(dired-warning ((t (:foreground ,sangria :weight bold))))
   `(dired-perm-write ((t (:foreground ,sangria))))
   `(dired-set-id ((t (:foreground ,zombie :weight bold))))
   `(dired-special ((t (:foreground ,garden))))

   ;; --- diredfl (colorful dired listings: perms, sizes, dates) ---------
   `(diredfl-dir-heading ((t (:foreground ,hollow :weight bold))))
   `(diredfl-dir-name ((t (:foreground ,kumashi))))
   `(diredfl-dir-priv ((t (:foreground ,kumashi))))
   `(diredfl-file-name ((t (:foreground ,text))))
   `(diredfl-file-suffix ((t (:foreground ,faint))))
   `(diredfl-symlink ((t (:foreground ,zombie))))
   `(diredfl-number ((t (:foreground ,sangria))))
   `(diredfl-date-time ((t (:foreground ,faint))))
   `(diredfl-deletion ((t (:foreground ,mihawk :weight bold))))
   `(diredfl-deletion-file-name ((t (:foreground ,mihawk :strike-through t))))
   `(diredfl-flag-mark ((t (:foreground ,hollow :weight bold :background ,overlay))))
   `(diredfl-flag-mark-line ((t (:background ,overlay))))
   `(diredfl-ignored-file-name ((t (:foreground ,muted))))
   `(diredfl-compressed-file-suffix ((t (:foreground ,zombie))))
   `(diredfl-compressed-file-name ((t (:foreground ,text))))
   `(diredfl-executable-flag ((t (:foreground ,garden :weight bold))))
   `(diredfl-read-priv ((t (:foreground ,sangria))))
   `(diredfl-write-priv ((t (:foreground ,sangria))))
   `(diredfl-exec-priv ((t (:foreground ,garden))))
   `(diredfl-no-priv ((t (:foreground ,muted))))
   `(diredfl-rare-priv ((t (:foreground ,zombie :weight bold))))
   `(diredfl-link-priv ((t (:foreground ,zombie))))
   `(diredfl-autofile-name ((t (:foreground ,faint :slant italic))))
   `(diredfl-tagged-autofile-name ((t (:foreground ,hollow :slant italic))))

   ;; --- flymake (built-in diagnostics: checkdoc, package-lint, etc.) ---
   `(flymake-error ((t (:underline (:style wave :color ,mihawk)))))
   `(flymake-warning ((t (:underline (:style wave :color ,sangria)))))
   `(flymake-note ((t (:underline (:style wave :color ,kumashi)))))
   `(flymake-error-echo ((t (:foreground ,mihawk))))
   `(flymake-warning-echo ((t (:foreground ,sangria))))
   `(flymake-note-echo ((t (:foreground ,kumashi))))

   ;; --- flycheck (same role, popular third-party alternative) ----------
   `(flycheck-error ((t (:underline (:style wave :color ,mihawk)))))
   `(flycheck-warning ((t (:underline (:style wave :color ,sangria)))))
   `(flycheck-info ((t (:underline (:style wave :color ,kumashi)))))
   `(flycheck-fringe-error ((t (:foreground ,mihawk :weight bold))))
   `(flycheck-fringe-warning ((t (:foreground ,sangria :weight bold))))
   `(flycheck-fringe-info ((t (:foreground ,kumashi :weight bold))))
   `(flycheck-error-list-error ((t (:foreground ,mihawk :weight bold))))
   `(flycheck-error-list-warning ((t (:foreground ,sangria :weight bold))))
   `(flycheck-error-list-info ((t (:foreground ,kumashi))))

   ;; --- eldoc / help hints & tooltips -----------------------------------
   `(eldoc-highlight-function-argument ((t (:foreground ,hollow :weight bold))))
   `(eldoc-box-body ((t (:background ,surface :foreground ,text))))
   `(eldoc-box-border ((t (:background ,muted))))

   ;; --- markdown-mode (widely used, close analog of markdownH1-H6) ----
   `(markdown-header-face ((t (:foreground ,hollow :weight bold))))
   `(markdown-header-face-1 ((t (:foreground ,hollow :weight bold))))
   `(markdown-header-face-2 ((t (:foreground ,sangria :weight bold))))
   `(markdown-header-face-3 ((t (:foreground ,garden :weight bold))))
   `(markdown-header-face-4 ((t (:foreground ,zombie :weight bold))))
   `(markdown-header-face-5 ((t (:foreground ,kumashi :weight bold))))
   `(markdown-header-face-6 ((t (:foreground ,mihawk :weight bold))))
   `(markdown-header-delimiter-face ((t (:foreground ,muted))))
   `(markdown-link-face ((t (:foreground ,kumashi :underline t))))
   `(markdown-url-face ((t (:foreground ,kumashi :slant italic :underline t))))
   `(markdown-code-face ((t (:foreground ,garden))))
   `(markdown-inline-code-face ((t (:foreground ,garden))))
   `(markdown-blockquote-face ((t (:foreground ,faint :slant italic))))
   `(markdown-list-face ((t (:foreground ,sangria))))
   `(markdown-bold-face ((t (:weight bold))))
   `(markdown-italic-face ((t (:slant italic))))
   `(markdown-strike-through-face ((t (:strike-through t :foreground ,muted))))
   `(markdown-markup-face ((t (:foreground ,muted))))

   ;; --- org-mode basics ------------------------------------------------
   `(org-level-1 ((t (:foreground ,hollow :weight bold))))
   `(org-level-2 ((t (:foreground ,sangria :weight bold))))
   `(org-level-3 ((t (:foreground ,garden :weight bold))))
   `(org-level-4 ((t (:foreground ,zombie :weight bold))))
   `(org-level-5 ((t (:foreground ,kumashi :weight bold))))
   `(org-level-6 ((t (:foreground ,mihawk :weight bold))))
   `(org-document-title ((t (:foreground ,hollow :weight bold))))
   `(org-document-info ((t (:foreground ,faint))))
   `(org-block ((t (:background ,surface :foreground ,text))))
   `(org-block-begin-line ((t (:background ,surface :foreground ,muted))))
   `(org-block-end-line ((t (:background ,surface :foreground ,muted))))
   `(org-code ((t (:foreground ,garden))))
   `(org-verbatim ((t (:foreground ,zombie))))
   `(org-link ((t (:foreground ,kumashi :underline t))))
   `(org-todo ((t (:foreground ,mihawk :weight bold))))
   `(org-done ((t (:foreground ,garden :weight bold))))
   `(org-date ((t (:foreground ,muted :underline t))))
   `(org-tag ((t (:foreground ,faint))))
   `(org-special-keyword ((t (:foreground ,muted))))
   `(org-quote ((t (:foreground ,faint :slant italic))))

   ;; --- org-agenda (separate face set from org-level-*, easy to miss) --
   `(org-agenda-structure ((t (:foreground ,hollow :weight bold))))
   `(org-agenda-date ((t (:foreground ,kumashi))))
   `(org-agenda-date-weekend ((t (:foreground ,faint))))
   `(org-agenda-date-today ((t (:foreground ,hollow :weight bold :underline t))))
   `(org-agenda-current-time ((t (:foreground ,sangria))))
   `(org-agenda-clocking ((t (:background ,med))))
   `(org-agenda-done ((t (:foreground ,garden))))
   `(org-agenda-dimmed-todo-face ((t (:foreground ,muted))))
   `(org-agenda-restriction-lock ((t (:background ,overlay))))
   `(org-agenda-filter-tags ((t (:foreground ,zombie))))
   `(org-time-grid ((t (:foreground ,muted))))
   `(org-scheduled ((t (:foreground ,text))))
   `(org-scheduled-today ((t (:foreground ,hollow))))
   `(org-scheduled-previously ((t (:foreground ,sangria))))
   `(org-upcoming-deadline ((t (:foreground ,sangria))))
   `(org-upcoming-distant-deadline ((t (:foreground ,faint))))
   `(org-imminent-deadline ((t (:foreground ,mihawk :weight bold))))
   `(org-warning ((t (:foreground ,mihawk :weight bold))))
   `(org-priority ((t (:foreground ,zombie))))
   `(org-column ((t (:background ,surface))))
   `(org-column-title ((t (:background ,surface :foreground ,hollow :weight bold))))

   ;; --- in-buffer completion popups (corfu) ----------------------------
   `(corfu-default ((t (:background ,surface :foreground ,text))))
   `(corfu-current ((t (:background ,overlay :foreground ,hollow :weight bold))))
   `(corfu-bar ((t (:background ,high))))
   `(corfu-border ((t (:background ,muted))))
   `(corfu-annotations ((t (:foreground ,muted :slant italic))))
   `(corfu-deprecated ((t (:foreground ,muted :strike-through t))))

   ;; --- in-buffer completion popups (company) --------------------------
   `(company-tooltip ((t (:background ,surface :foreground ,text))))
   `(company-tooltip-selection ((t (:background ,overlay :foreground ,hollow :weight bold))))
   `(company-tooltip-common ((t (:foreground ,hollow :weight bold))))
   `(company-tooltip-common-selection ((t (:foreground ,hollow :weight bold :underline t))))
   `(company-tooltip-annotation ((t (:foreground ,muted :slant italic))))
   `(company-tooltip-annotation-selection ((t (:foreground ,faint :slant italic))))
   `(company-tooltip-mouse ((t (:background ,overlay))))
   `(company-tooltip-search ((t (:background ,med :foreground ,sangria))))
   `(company-tooltip-search-selection ((t (:background ,med :foreground ,sangria))))
   `(company-scrollbar-bg ((t (:background ,surface))))
   `(company-scrollbar-fg ((t (:background ,high))))
   `(company-preview ((t (:foreground ,muted))))
   `(company-preview-common ((t (:foreground ,hollow :weight bold))))
   `(company-preview-search ((t (:background ,med :foreground ,sangria))))

   ;; --- minibuffer completion UI (vertico / orderless) -----------------
   `(vertico-current ((t (:background ,overlay :foreground ,hollow :weight bold))))
   `(vertico-group-title ((t (:foreground ,faint :weight bold))))
   `(vertico-group-separator ((t (:foreground ,muted :strike-through t))))
   `(vertico-multiline ((t (:foreground ,muted))))
   `(orderless-match-face-0 ((t (:foreground ,hollow :weight bold))))
   `(orderless-match-face-1 ((t (:foreground ,kumashi :weight bold))))
   `(orderless-match-face-2 ((t (:foreground ,garden :weight bold))))
   `(orderless-match-face-3 ((t (:foreground ,zombie :weight bold))))))

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'perona)

;;; perona-theme.el ends here
