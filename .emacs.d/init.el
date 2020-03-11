;(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
;(require 'package)

;(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
;;(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq inhibit-startup-screen t)

;;;;; Straight preamble
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

; In order to override what use-package is doing, we have to clone-and-load
; use-package. It's never used beyond merely being loaded
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

(use-package evil
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  :ensure t
  )
(use-package ivy
  :ensure t)
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
             :ensure t)
(use-package centaur-tabs
	     :config
	     (centaur-tabs-mode t)
             :ensure t)
(use-package lsp-mode
  :ensure t
  :hook (
	 (python-mode . lsp))
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
(use-package company-lsp
  :after company
  :commands company-lsp
  :config
  (push 'company-lsp company-backends)
  ;:init(lambda () (
  ;	; Have to override this odd keymap in company mode
  ;	(define-key company-active-map (kbd "C-w") 'evil-delete-backward-word)
  ;	(define-key company-active-map (kbd "C-l") 'company-show-location))))
  :init(
	define-key company-active-map (kbd "C-w") 'evil-delete-backward-word
	))

(use-package adaptive-wrap
  :ensure t
  :init (defun my-activate-adaptive-wrap-prefix-mode ()
	"Toggle `visual-line-mode' and `adaptive-wrap-prefix-mode' simultaneously."
	(adaptive-wrap-prefix-mode (if visual-line-mode 1 -1)))
	(add-hook 'visual-line-mode-hook 'my-activate-adaptive-wrap-prefix-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Disable our startup screen
(setq inhibit-startup-screen t)

; Turn on the good nootch
(load-theme 'doom-molokai t)

;; visual-fill-column causes visual-line-mode to soft-wrap long lines at the
;; column indicated in the 'fill-column' variable.
;(use-package visual-fill-column
;  :ensure t
;  :config
;  (setq-default fill-column 120)
;  (global-visual-fill-column-mode))

; Turn on ivy, providing us that delicious autocomplete and fuzzy match
(ivy-mode 1)
; By default when in an Ivy mode, if you backspace beyond the start of
; input then Ivy will exit the minibuf. Since I have a very high
; key-repeat rate, that happens waay too easily for me. So, disable
; the behavior.
(setq ivy-on-del-error-function #'ignore)

; Turn on relative line numbers with absolute line numbers for the line we're
; currently on
(setq display-line-numbers-type 'relative
      display-line-numbers-current-absolute t)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
; Ensure that our line numbers nicely padded by default.
(setq-default display-line-numbers-width 5)

; Tell emacs that when it comes to loading lisp files, if there's a *.el and a
; *.elc file, prefer loading the newer file
(setq load-prefer-newer t)

; Disable menubar in emacs
(menu-bar-showhide-tool-bar-menu-customize-disable)

; Highlight trailing whitespace
(setq-default show-trailing-whitespace t)

;;; Key bindings ;;;

; Org-mode keys
(global-set-key "\C-ca" 'org-agenda)
(evil-define-key 'normal 'global (kbd "SPC c") 'org-capture)
(define-key evil-normal-state-map (kbd "SPC j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "SPC k") 'evil-previous-visual-line)
(define-key evil-normal-state-map (kbd "SPC d v") 'describe-variable)
(define-key evil-normal-state-map (kbd "SPC d f") 'describe-function)
(define-key evil-normal-state-map (kbd "SPC b") 'counsel-bookmark)
(define-key evil-normal-state-map (kbd "SPC t f") 'neotree-toggle)
(define-key evil-normal-state-map (kbd "SPC f f") 'counsel-projectile-find-file)
(define-key evil-normal-state-map (kbd "SPC SPC") #'counsel-M-x)
(define-key global-map (kbd "C-l") 'evil-window-right)
(define-key global-map (kbd "C-h") 'evil-window-left)
(define-key global-map (kbd "C-j") 'evil-window-down)
(define-key global-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-w v") 'split-window-horizontally)
(define-key evil-normal-state-map (kbd "C-w s") 'split-window-vertically)
(define-key evil-normal-state-map (kbd "SPC e") 'eval-last-sexp)
(define-key evil-normal-state-map (kbd "SPC m") 'centaur-tabs-forward)
(define-key evil-normal-state-map (kbd "SPC n") 'centaur-tabs-backward)

; Following code/comments come from here: https://orgmode.org/worg/org-tutorials/org4beginners.html
;; Enable transient mark mode
(transient-mark-mode 1)

;;;;Org mode configuration
;; Enable Org mode
(require 'org)
;; Make Org mode work with files ending in .org
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; The above is the default in recent emacsen

;; Set a default notes file
;(setq org-default-notes-file "/home/leland/vimwiki/leland.org"
;      initial-buffer-choice  org-default-notes-file)


; Taken from here: http://members.optusnet.com.au/~charles57/GTD/datetree.html
(setq org-capture-templates
  (quote (
    ("t" "Task Diary" entry (file+datetree
      "/home/leland/vimwiki/leland.org")
      "* TODO %^{Description}  %^g
%?
Added: %U\n  \n")
    ("n" "Notes" entry (file+datetree
      "/home/leland/vimwiki/leland.org")
      "* %^{Description} %^g %?
Added: %U\n  \n")
)))

; Overwrite this entire function used internally with org-datetree so that
; it'll recognize years with statistics cookies
(advice-add 'org-datetree-find-year-create :override
;(defun org-datetree-find-year-create (year)
;  "Find the YEAR datetree or create it."
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Don't mess with this auto-generated block
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;'(custom-enabled-themes (quote (doom-molokai)))
 '(custom-safe-themes
   (quote
    ("3a3de615f80a0e8706208f0a71bbcc7cc3816988f971b6d237223b6731f91605" default)))
 '(org-agenda-files (quote ("/tmp/test.org")))
 '(package-selected-packages
   (quote
    (doom-themes evil-collection htmlize counsel ivy helm visual-fill-column evil-org use-package evil evil-visual-mark-mode)))
 '(safe-local-variable-values
   (quote
    ((Eval setq-default fill-column 100)
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
 )
