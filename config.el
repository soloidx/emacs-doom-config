;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Ider Delzo"
      user-mail-address "soloidx@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font (font-spec :family "Meslo LG M DZ for Powerline" :size 11))
(setq doom-variable-pitch-font (font-spec :family "Meslo LG M DZ for Powerline" :size 12))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-modeline-major-mode-icon t)
(setq doom-theme 'doom-city-lights)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/dropbox/org/")
;;setting the org-agenda
(setq org-agenda-files (list "~/org"))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq-default evil-escape-key-sequence "fd")

(setq mac-right-option-modifier nil)

;; UI
;; (add-to-list 'default-frame-alist '(fullscreen . maximized))
;; (after! ivy-posframe
;;   (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center)))
;;   )

(setq fancy-splash-image "~/.doom.d/apple_logo.png")

;; Nyan mode

(setq-default nyan-wavy-trail t)
(nyan-mode)
(nyan-start-animation)

;; Treemacs

(treemacs-resize-icons 12)
(setq doom-treemacs-use-generic-icons nil)
(setq doom-treemacs-enable-variable-pitch t)
(setq doom-themes-treemacs-theme "doom-colors")


;; LSP general

(after! lsp-mode
  (setq lsp-enable-symbol-highlighting nil))

(after! lsp-ui
  (add-hook! 'lsp-ui-mode-hook
             (run-hooks (intern (format "%s-lsp-ui-hook" major-mode)))))


;; Python

(map! :after python
      :localleader
      :map python-mode-map
      :prefix "v"
      "w" #'pyvenv-workon
      "p" #'pipenv-activate)

;; (set-formatter! 'black "black -q -l 80 -")

(after! lsp-python-ms
  (set-lsp-priority! 'mspyls 1))

(defun internal-python-flycheck-setup()
  "Setup flycheck for only python and lsp"
  (flycheck-add-next-checker 'lsp 'python-flake8))

(add-hook 'python-mode-lsp-ui-hook
          #'internal-python-flycheck-setup)


;; HTML

(after! web-mode
  (set-formatter! 'html-tidy
    '("prettier" "--parser" "html")
    )
  )


;; Multiterm

(map! :leader
      (:prefix-map ("e" . "Multi-term")
       :desc "Open new terminal"            "t" #'multi-term
       :desc "Go to next terminal"          "n" #'multi-term-next
       :desc "Go to previous terminal"      "p" #'multi-term-prev))


;; Dash

(map! :leader
      (:prefix-map ("d" . "Dash")
       :desc "Dash at point"            "d" #'dash-at-point))

;; Spell

(with-eval-after-load "ispell"
  (setq ispell-dictionary "en_US,es_ANY")
  (ispell-set-spellchecker-params)
  (ispell-hunspell-add-multi-dic "en_US,es_ANY")
  )

;; Org mode
(after! org
  (setq org-log-done 'time))
(use-package! org-fancy-priorities
  :hook (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '("⚡" "⬆" "⬇" "☕")))

;; Wakatime
(global-wakatime-mode)
