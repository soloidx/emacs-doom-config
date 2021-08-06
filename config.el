;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Ider Delzo (Personal key)"
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
(setq doom-font (font-spec :family "Meslo LG M DZ for Powerline" :size 11))
(setq doom-variable-pitch-font (font-spec :family "Meslo LG M DZ for Powerline" :size 12))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-modeline-major-mode-icon t)
(setq doom-theme 'doom-dracula)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/org/")
;;setting the org-agenda
(setq org-agenda-files (list "~/Dropbox/org"))

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
(add-to-list 'default-frame-alist '(fullscreen . maximized))
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
  (setq lsp-enable-symbol-highlighting nil)
  (setq +format-with-lsp nil)
  ;; no real time syntax check
  ;; (setq lsp-diagnostics-provider :none)
 )

(after! lsp-ui
  (add-hook! 'lsp-ui-mode-hook
             (run-hooks (intern (format "%s-lsp-ui-hook" major-mode)))))


;; Python

(after! python
  (setq flycheck-flake8rc ".flake8")
  (setq flycheck-pylintrc "pyproject.toml")
  (setq poetry-tracking-strategy 'projectile)
  (poetry-tracking-mode)
  )

(map! :after python
      :localleader
      :map python-mode-map
      :prefix "v"
      "w" #'pyvenv-workon
      "p" #'pipenv-activate)

;; (set-formatter! 'black "black -q -l 80 -")

(after! lsp-python-ms
  (set-lsp-priority! 'mspyls 1))

(defun internal-python-lsp-setup()
 (setq lsp-diagnostics-provider :none)
 (add-to-list 'lsp-file-watch-ignored "[/\\\\]\\.mypy_cache\\'")
 (add-to-list 'lsp-file-watch-ignored "[/\\\\]\\.venv\\'")
 (add-to-list 'lsp-file-watch-ignored "[/\\\\]\\nltk_data\\'")
 (add-to-list 'lsp-file-watch-ignored "[/\\\\]flycheck_[^/\\\\]*\\.py\\'")
)

(defun setup-venv-lsp()

  )

(add-hook 'python-mode-lsp-ui-hook
           #'internal-python-lsp-setup)

(add-hook 'pyvenv-post-activate-hooks
          #'setup-venv-lsp)


;; HTML

(after! web-mode
  (set-formatter! 'html-tidy
    '("prettier" "--parser" "html")
    )
  )


;; Multiterm

;; (map! :leader
;;       (:prefix-map ("e" . "Multi-term")
;;        :desc "Open new terminal"            "t" #'multi-term
;;        :desc "Go to next terminal"          "n" #'multi-term-next
;;        :desc "Go to previous terminal"      "p" #'multi-term-prev))


;; Dash

(map! :leader
      (:prefix-map ("d" . "Dash")
       :desc "Dash at point"            "d" #'dash-at-point))

(after! dash-at-point
        (add-to-list 'dash-at-point-mode-alist '(js2-mode . "javascript,backbone,angularjs,react,nodejs"))
        )

;; Spell

 (after! flyspell
   (setenv "DICTIONARY" "en_US")
   (setq ispell-program-name "hunspell")
   (setq ispell-really-hunspell t)
   (ispell-set-spellchecker-params)
   (ispell-hunspell-add-multi-dic "en_US,es_PE")
   (setq ispell-dictionary "en_US,es_PE")
   )

;; Wakatime
(global-wakatime-mode)
