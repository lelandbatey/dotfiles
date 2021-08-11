
(setq inhibit-startup-screen t)

(set-frame-font "Inconsolata for Powerline:pixelsize=16:foundry=PfEd:weight=normal:slant=normal:width=normal:spacing=100:scalable=true" t)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; In order to override what use-package is doing, we have to clone-and-load
;; use-package. It's never used beyond merely being loaded
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

(use-package evil
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  :ensure t
  )
(use-package ivy
  :ensure t
  :init
  (setq ivy-re-builders-alist
        '((t . ivy--regex-ignore-order)))
  )
(use-package counsel
  :ensure t)
(use-package evil-collection
  :after evil
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-collection-init))
(use-package doom-themes)
;; evil-org provides nicer keybindings for various parts of org-mode, but in
;; evil-mode. It's a nice compatibility layer.
(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(require 'evil)
(evil-mode t)

(use-package projectile
  :init
  (setq
   projectile-enable-caching 1
   projectile-globally-ignored-files '("~" ".swp")
   projectile-globally-ignored-directories '(".mypy_cache")
   projectile-completion-system 'ivy
   projectile-switch-project-action 'counsel-projectile-switch-project
   )
  :config
  (projectile-global-mode)
  )
(use-package counsel-projectile
  :after projectile counsel
  )

(use-package neotree
  :ensure t
  :config (setq neo-autorefresh nil))
(use-package centaur-tabs
  :config
  (centaur-tabs-mode t)
  :ensure t)
(use-package lsp-mode
  :ensure t
  :hook (
         (python-mode . lsp))
  :config
  ;; Re-map the prefix expected by lsp-mode
  (setq lsp-keymap-prefix "M-l")
  (setq lsp-log-io t)
  )
(use-package lsp-ui
  :commands lsp-ui-mode
  :config
  (setq
   lsp-ui-sideline-show-symbol t
   lsp-ui-sideline-show-hover nil
   )
  (setq
   lsp-ui-doc-header t
   lsp-ui-doc-include-signature t
   lsp-ui-doc-position 'top
   lsp-ui-doc-alignment 'window
   lsp-ui-doc-use-childframe t
   )
  )

;; Company gives us the menus showing what lsp sees
(use-package company-lsp
  :after company
  :commands company-lsp
  :config
  (push 'company-lsp company-backends)
  :init(
        ;; Have to override this odd keymap in company mode, as
        ;; otherwise we can't use Ctrl-w to delete the last word
        define-key company-active-map (kbd "C-w") 'evil-delete-backward-word
        ))

;; Indentation of softwraped code
(use-package adaptive-wrap
  :ensure t
  :init (defun my-activate-adaptive-wrap-prefix-mode ()
          "Toggle `visual-line-mode' and `adaptive-wrap-prefix-mode' simultaneously."
          (adaptive-wrap-prefix-mode (if visual-line-mode 1 -1)))
  (add-hook 'visual-line-mode-hook 'my-activate-adaptive-wrap-prefix-mode))

;; Automatic code formatting; I manually modify the code in this repo
;; so that it formats via YAPF
(use-package format-all
  :ensure t
  :init
  (defvar bmacs-should-format-buffer t
    "Indicates the whether to format all buffers on save")
  (defun bmacs-toggle-autoformat-buffer ()
    (interactive)
    "Toggles wether the to automatically format all buffer."
    (progn (if (bound-and-true-p bmacs-should-format-buffer)
               (setq bmacs-should-format-buffer nil)
             (setq bmacs-should-format-buffer t))
           (print (bound-and-true-p bmacs-shoule-format-buffer)))
    )
  (defun bmacs-conditional-format-buffer ()
    (interactive)
    "Will format the current buffer only if the global variable
'bmacs-should-format-buffer' is true. Otherwise, it does not
format the buffer."
    (when (bound-and-true-p bmacs-should-format-buffer)
      (format-all-buffer)
      (message "buffer is automatically formated")))
  (add-hook 'before-save-hook #'bmacs-conditional-format-buffer))

;; HTML-ize is required for org-mode to work how I want
(use-package htmlize :ensure t)

;; An external package which provides nice hlsearch-like behavior
(use-package evil-search-highlight-persist :ensure t
  :init (global-evil-search-highlight-persist t)
  (setq evil-search-highlight-persist-all-windows t))

;; In order to have "<s{tab}" shortcuts work in org-mode, we have to include
;; org-tempo:
;;     https://emacs.stackexchange.com/a/47370
(require 'org-tempo)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Disable our startup screen
(setq inhibit-startup-screen t)

;; Redefine the the physical key which maps to the logical 'super'
;; key. Make it so that when I press 'alt', Emacs sees 'super'. I do
;; this because I heavily use my actual 'super' key for i3 stuff.
;;(setq x-super-keysym 'alt)
;; Turn on the good nootch, a monokai-inspired editor theme
(load-theme 'doom-molokai t)


;; tell Emacs to follow symlinks when jumping around code without
;; asking permission
(setq vc-follow-symlinks t)

;; Turn on softwrap everywhere
(global-visual-line-mode 1)

;; electric-pair-mode means adding an opening brace automatically also
;; adding a closing brace. Same applies for quotes.
(electric-pair-mode 1)

;; Turn on ivy, providing us that delicious autocomplete and fuzzy match
(ivy-mode 1)
;; By default when in an Ivy mode, if you backspace beyond the start of
;; input then Ivy will exit the minibuf. Since I have a very high
;; key-repeat rate, that happens waay too easily for me. So, disable
;; the behavior.
(setq ivy-on-del-error-function #'ignore)

;; Emacs doesn't save command history across restarts by default, so
;; turn that on
(savehist-mode 1)

;; Always highlight matching parenthesis
(show-paren-mode)

;; Turn on relative line numbers with absolute line numbers for the line we're
;; currently on
(setq display-line-numbers-type 'relative
      display-line-numbers-current-absolute t)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
;; Ensure that our line numbers nicely padded by default.
(setq-default display-line-numbers-width 3)

;; Tell emacs that when it comes to loading lisp files, if there's a *.el and a
;; *.elc file, prefer loading the newer file
(setq load-prefer-newer t)

;; Disable menubar in emacs
(menu-bar-showhide-tool-bar-menu-customize-disable)

;; Highlight trailing whitespace
(setq-default show-trailing-whitespace t)

;; Emacs really likes to mix tabs and spaces when indenting
;; things. Disable anything other than spaces.
(setq-default indent-tabs-mode nil)

;; Move the backups directory of emacs so that it won't leave all
;; these garbage files all over the place. https://stackoverflow.com/a/2680682
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t    ; Don't delink hardlinks
      version-control t      ; Use version numbers on backups
      delete-old-versions t  ; Automatically delete excess backups
      kept-new-versions 20   ; how many of the newest versions to keep
      kept-old-versions 5    ; and how many of the old
      )


;;; Key bindings ;;;

;; Org-mode keys
(global-set-key "\C-ca" 'org-agenda)
(evil-define-key 'normal 'global (kbd "SPC o c") 'org-capture)
(define-key evil-normal-state-map (kbd "SPC j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "SPC c d") 'comment-line)
(define-key evil-visual-state-map (kbd "SPC c d") 'comment-line)
(define-key evil-normal-state-map (kbd "SPC k") 'evil-previous-visual-line)
(define-key evil-normal-state-map (kbd "SPC d v") 'describe-variable)
(define-key evil-normal-state-map (kbd "SPC d f") 'describe-function)
(define-key evil-normal-state-map (kbd "SPC b") 'counsel-bookmark)
(define-key evil-normal-state-map (kbd "SPC B") 'switch-to-buffer)
(define-key evil-normal-state-map (kbd "SPC t f") 'neotree-toggle)
(define-key evil-normal-state-map (kbd "SPC f f") 'counsel-projectile-find-file)
(define-key evil-normal-state-map (kbd "SPC f l") 'lsp-format-buffer)
(define-key evil-normal-state-map (kbd "SPC SPC") #'execute-extended-command)
(define-key global-map (kbd "C-l") 'evil-window-right)
(define-key global-map (kbd "C-h") 'evil-window-left)
(define-key global-map (kbd "C-j") 'evil-window-down)
(define-key global-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-w v") 'split-window-horizontally)
(define-key evil-normal-state-map (kbd "C-w s") 'split-window-vertically)
(define-key evil-normal-state-map (kbd "SPC e") 'eval-last-sexp)
(define-key evil-normal-state-map (kbd "SPC m") 'centaur-tabs-forward)
(define-key evil-normal-state-map (kbd "SPC n") 'centaur-tabs-backward)
;; Re-map the prefix expected by lsp-mode
;;(setq lsp-keymap-prefix "SPC l")
(setq lsp-keymap-prefix "M-l")

;;; following code/comments come from here: https://orgmode.org/worg/org-tutorials/org4beginners.html
;; Enable transient mark mode
(transient-mark-mode 1)

;;;; Python mode
;; Hook the load so that the '_' (underscore) character is included in
;; the definition of a "word", allowing the * command to select words
;; with underscores, same as how Vim behaves
(add-hook 'python-mode-hook
          (lambda () (modify-syntax-entry ?_ "w")))

;;;;Org mode configuration
;; Enable Org mode
(require 'org)
;; Tell org-babel to load languages for dot, allowing for embedding graphviz
(org-babel-do-load-languages
 'org-babel-load-languages '((dot . t)))
;; Turn on org-babel support for plantuml
(setq org-plantuml-jar-path (expand-file-name "/home/leland/bin/plantuml.1.2020.7.jar"))
(add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
(org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))
;; Cause Org to redisplay images after executing Babel blocks which regen images.
(defun help/org-babel-after-execute-hook ()
  "HELP settings for the `org-babel-after-execute-hook'.

This does not interfere with exports.

Attribution: URL
`https://lists.gnu.org/archive/html/emacs-orgmode/2015-01/msg00534.html'"
  (interactive)
  (org-redisplay-inline-images))

(add-hook 'org-babel-after-execute-hook #'help/org-babel-after-execute-hook)
;; Make Org mode work with files ending in .org
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; The above is the default in recent emacsen

;; Set a default notes file
;;(setq org-default-notes-file "/home/leland/vimwiki/leland.org"
;;      initial-buffer-choice  org-default-notes-file)


;; Taken from here: http://members.optusnet.com.au/~charles57/GTD/datetree.html
(setq org-capture-templates
      (quote (
              ("t" "Task Diary" entry (file+datetree
                                       "/home/leland/vimwiki/leland.org")
               "* TODO %^{Description}  %^g
%?
Added: %U\n  \n\n")
              ("n" "Notes" entry (file+datetree
                                  "/home/leland/vimwiki/leland.org")
               "* %^{Description} %^g %?
Added: %U\n  \n\n")
              )))

;; Overwrite this entire function used internally with org-datetree so that
;; it'll recognize years with statistics cookies
(advice-add 'org-datetree-find-year-create :override
            ;;(defun org-datetree-find-year-create (year)
            ;;  "Find the YEAR datetree or create it."
            (lambda (year)
              (let ((re "^\\*+[ \t]+\\([12][0-9]\\{3\\}\\)\\(\\s-*\\[.*\\]\\s-*$\\)?\\(\\s-*?\\([ \t]:[[:alnum:]:_@#%]+:\\)?\\s-*$\\)")
                    match)
                (goto-char (point-min))
                (while (and (setq match (re-search-forward re nil t))
                            (goto-char (match-beginning 1))
                            (< (string-to-number (match-string 1)) year)))
                (cond
                 ((not match)
                  (goto-char (point-max))
                  (or (bolp) (newline))
                  (org-datetree-insert-line year))
                 ((= (string-to-number (match-string 1)) year)
                  (goto-char (point-at-bol)))
                 (t
                  (beginning-of-line 1)
                  (org-datetree-insert-line year))))
              ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Don't mess with this auto-generated block
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3a3de615f80a0e8706208f0a71bbcc7cc3816988f971b6d237223b6731f91605" default)))
 '(org-agenda-files (quote ("/tmp/test.org")))
 '(package-selected-packages
   (quote
    (doom-themes evil-collection htmlize counsel ivy helm visual-fill-column evil-org use-package evil evil-visual-mark-mode)))
 '(safe-local-variable-values
   (quote
    ((eval setq org-confirm-babel-evaluate nil)
     (eval org-confirm-babel-evaluate nil)
     (eval org-display-inline-images t t)
     (Eval setq-default fill-column 100)
     (eval add-hook
           (quote after-save-hook)
           (quote org-html-export-to-html)
           t t)
     (eval setq-default fill-column 100)
     (eval setq-default fill-column 80)
     (eval visual-line-mode t)
     (visual-line-mode . t)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-ex-search ((t (:background "#fd971f" :foreground "#1B2229" :weight normal))))
 '(lazy-highlight ((t (:background "#9c91e4" :foreground "#1B2229" :weight normal))))
 '(lsp-face-highlight-read ((t (:background "#727280" :foreground "#ffffff" :weight normal))))
 '(lsp-face-highlight-write ((t (:background "#727280" :foreground "#ffffff" :weight normal))))
 '(show-paren-match ((t (:background "#1B2229" :foreground "#e74c3c" :weight normal)))))
