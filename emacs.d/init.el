;;;; CUSTOM
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

;;;; INITIAL
(setq ns-use-srgb-colorspace t)

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; chill Winston
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)

;;;; PACKAGES
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(require 'cl)
(defvar prelude-packages '(
                           ag
                           ansible
                           anzu
                           auto-package-update
                           autopair
                           better-defaults
                           company
                           company-go
                           company-inf-ruby
                           cpputils-cmake
                           csv-mode
                           direx
                           discover
                           dockerfile-mode
                           enh-ruby-mode
                           evil
                           exec-path-from-shell
                           expand-region
                           fic-mode
                           find-file-in-repository
                           flx-ido
                           flycheck
                           flycheck-color-mode-line
                           flycheck-rust
                           flyspell-lazy
                           gist
                           git-commit-mode
                           git-rebase-mode
                           git-timemachine
                           go-direx
                           go-eldoc
                           go-mode
                           go-snippets
                           highlight-symbol
                           ibuffer-vc
                           ido-vertical-mode
                           idomenu
                           imenu-anywhere
                           inf-ruby
                           ir-black-theme
                           js2-mode
                           json-mode
                           magit
                           markdown-mode
                           paredit
                           popwin
                           processing-mode
                           projectile
                           protobuf-mode
                           puppet-mode
                           rainbow-delimiters
                           rust-mode
                           scala-mode
                           smart-mode-line
                           smex
                           smooth-scrolling
                           thrift
                           toml-mode
                           undo-tree
                           web-mode
                           yaml-mode
                           yasnippet
                           zenburn-theme
    )
  "A list of packages to ensure are installed at launch.")

(defun prelude-packages-installed-p ()
  (loop for p in prelude-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

(unless (prelude-packages-installed-p)
  ;; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ;; install the missing packages
  (dolist (p prelude-packages)
    (when (not (package-installed-p p))
      (package-install p))))

;; update weekly
(require 'auto-package-update)
(setq auto-package-update-interval 7)
(auto-package-update-maybe)

;;;; GLOBAL

;; don't show all the damn modes
(require 'rich-minority)
(setq rm-blacklist (quote (" WS"
                           " FIC"
                           " pair"
                           " ElDoc"
                           " yas"
                           " Projectile"
                           " MRev"
                           " company"
                           " Fly"
                           " GitGutter"
                           " Paredit"
                           " Undo-Tree"
                           " Anzu"
                           " hl-s"
                           " VHl"
                           " Abbrev")))

;; use smart-mode-line
(require 'smart-mode-line)
(setq sml/theme 'respectful)
(sml/setup)

(load-theme 'zenburn t)

;; it's cool if yasnippet doesn't say everything it's thinking
(require 'yasnippet)
(setq yas-verbosity 1)
(yas-global-mode)

;; show total matches in modeline
(global-anzu-mode t)

;; highlight current symbol in prog-mode
(add-hook 'prog-mode-hook 'highlight-symbol-mode)

;; use autopair everywhere
(autopair-global-mode t)

;; rely on electric indents, since they're improving
(electric-indent-mode t)

;; add volatile highlights to edit actions
;(require 'volatile-highlights)
;(volatile-highlights-mode t)

;; use whitespace mode, and mark lines longer than 80 characters
(require 'whitespace)
(global-whitespace-mode)
(setq whitespace-style '(face empty lines-tail trailing))
(setq whitespace-line-column 80)
(setq whitespace-global-modes '(not git-commit-mode))

;; also fill paragraphs to 80 characters
(setq-default fill-column 80)
(defun cos/set-markdown-fill-column ()
  (setq fill-column 72))
(add-hook 'markdown-mode-hook 'cos/set-markdown-fill-column)

;; add context menus for things
(global-discover-mode t)

;; use line and column numbers in prog-mode
;(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'prog-mode-hook 'column-number-mode)

;; words are different when programming
(add-hook 'prog-mode-hook 'subword-mode)

;; highlight the current line
(global-hl-line-mode)

;; highlight fixme comments
(add-hook 'prog-mode-hook 'fic-mode)

;; always use ElDoc in prog-mode
(add-hook 'prog-mode-hook 'eldoc-mode)

;; overwrite selections
(delete-selection-mode t)

;; use projectile everywhere
(projectile-global-mode t)

;; group ibuffer by vc root
(add-hook 'ibuffer-hook 'ibuffer-vc-set-filter-groups-by-vc-root)

;; enable flycheck everywhere
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)

;; a tab is 4 spaces wide
(setq-default tab-width 4)

;; don't show the welcome message
(setq inhibit-splash-screen t)

;; shut up shut up shut up
(setq ring-bell-function 'ignore)

;; always delete trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; use core-utils for dired
(setq insert-directory-program "gls")

;; always prefer UTF-8
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; always add a trailing newline - POSIX
(setq require-final-newline t)

;; no need to be so verbose
(defalias 'yes-or-no-p 'y-or-n-p)

;; use undo-tree
(global-undo-tree-mode)

;; bind windmove to super-arrows
(windmove-default-keybindings 'super)

;; enable rainbow delimiters
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;;;; C/C++

(add-hook 'c-mode-hook 'cppcm-reload-all)
(add-hook 'c++-mode-hook 'cppcm-reload-all)

;;;; IDO

;; use flx-ido
(flx-ido-mode t)

;; use ido vertically
(ido-vertical-mode t)

;; don't complete on extensions with ido
(setq ido-ignore-extensions t)

;; disable ido faces to see flx highlights
(setq ido-use-faces nil)

;; autoload idomenu
(autoload 'idomenu "idomenu" nil t)

;;;; ELISP

;; surface Elisp sections in imenu
(defun cos/imenu-elisp-sections ()
  (setq imenu-generic-expression '(("Sections" "^;;;; \\(.+\\)" 1)))
  (imenu-add-to-menubar "Index"))
(add-hook 'emacs-lisp-mode-hook 'cos/imenu-elisp-sections)

;; use paredit
(add-hook 'lisp-mode-hook 'paredit-mode)

;;;; COCOA

(defun cos/configure-cocoa ()
  ;; load PATH variable from shell, since setting env bars in Emacs
  ;; is crazy painful
  (exec-path-from-shell-initialize)

  ;; open up maximized-ish
  (let ((px (display-pixel-width))
        (py (display-pixel-height))
        (fx (frame-char-width))
        (fy (frame-char-height))
        tx ty)
    (setq tx (- (/ px fx) 7))
    (setq ty (- (/ py fy) 4))
    (setq initial-frame-alist '((top . 2) (left . 2)))
    (add-to-list 'default-frame-alist (cons 'width tx))
    (add-to-list 'default-frame-alist (cons 'height ty)))

  ;; don't scroll like a maniac
  (setq mouse-wheel-scroll-amount '(1))
  (setq mouse-wheel-progressive-speed nil)
)
(if (memq window-system '(mac ns)) (cos/configure-cocoa))

;;;; COMPANY

(require 'company)

;; use a bigger popup window
(setq company-tooltip-limit 20)

;; only auto-complete on key binding
(setq company-idle-delay nil)

;; take over hippie-expand
(defun cos/enable-company-mode ()
  (company-mode 1)
  (define-key (current-local-map) [remap hippie-expand] 'company-complete))
(add-hook 'prog-mode-hook 'cos/enable-company-mode)

;; strictly limit completion in Go, since it's totally accurate
(defadvice company-go (around fix-company-go-prefix activate)
      ad-do-it
      (when (eql (ad-get-arg 0) 'prefix)
        (setq ad-return-value (company-grab-word))))

;;;; SPELLING

(require 'ispell)

;; use aspell instead of ispell
(setq ispell-program-name "aspell")

;; automatically check spelling for text
(add-hook 'text-mode-hook 'flyspell-mode)

;; spell check comments and strings when programming
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

;; spell check git commit messages
(add-hook 'git-commit-mode-hook 'flyspell-mode)

;;;; TERMINAL

(defadvice ansi-term (after advise-ansi-term-coding-system)
    (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))
(ad-activate 'ansi-term)

(defun cos/visit-term-buffer ()
  "Create or visit a terminal buffer."
  (interactive)
  (if (not (get-buffer "*ansi-term*"))
      (progn
        (split-window-sensibly (selected-window))
        (other-window 1)
        (ansi-term "/usr/local/bin/bash"))
    (switch-to-buffer-other-window "*ansi-term*")))

(add-hook 'term-mode-hook (lambda()
                            (setq yas-dont-activate t)))

;;;; GO

;; hard-code GOROOT and GOPATH for now
(setenv "GOROOT" "/usr/local/go")
(setenv "GOPATH" "/Users/cos/src/go")

(require 'go-mode)

;; use goimports instead of gofmt
(setq gofmt-command "goimports")

;; always run goimports before saving .go files
(add-hook 'before-save-hook 'gofmt-before-save)

(defun cos/configure-go-mode ()
  ;; improve imenu results
  (setq imenu-generic-expression
        '(("type" "^type *\\([^ \t\n\r\f]*\\)" 1)
          ("func" "^func *\\(.*\\) {" 1)))
  (imenu-add-to-menubar "Index")

  ;; use go-eldoc
  (go-eldoc-setup)

  ;; only use gocode as company backend
  (set (make-local-variable 'company-backends) '(company-go))

  (local-set-key (kbd "C-c i") 'go-goto-imports))

(add-hook 'go-mode-hook 'cos/configure-go-mode)

;;;; RUST

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

;;;; DIREX

(require 'popwin)
(popwin-mode 1)

(push '(direx:direx-mode :position left :width 25 :dedicated t)
      popwin:special-display-config)
(global-set-key (kbd "C-c l d") 'direx:jump-to-directory-other-window)

(push '("^\*go-direx:" :regexp t :position left :width 0.4 :dedicated t)
      popwin:special-display-config)
(define-key go-mode-map (kbd "C-c l g") 'go-direx-pop-to-buffer)

;;;; MAGIT

(require 'magit)

(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(defun magit-quit-session ()
  "Restores the previous window configuration and kills the magit buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))

(define-key magit-status-mode-map (kbd "q") 'magit-quit-session)

;;;; JAVASCRIPT

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;;;; KEYBINDINGS

(global-set-key (kbd "C-c c")       'compile)
(global-set-key (kbd "C-c g")       'magit-status)
(global-set-key (kbd "C-c h n")     'git-gutter:next-hunk)
(global-set-key (kbd "C-c h p")     'git-gutter:previous-hunk)
(global-set-key (kbd "C-c h r")     'git-gutter:revert-hunk)
(global-set-key (kbd "C-c i")       'idomenu)
(global-set-key (kbd "C-c l p")     'list-packages)
(global-set-key (kbd "C-c r")       'recompile)
(global-set-key (kbd "C-c t")       'cos/visit-term-buffer)
(global-set-key (kbd "C-c +")       'er/expand-region)
(global-set-key (kbd "C-c -")       'er/contract-region)
(global-set-key (kbd "C-c SPC")     'ace-jump-mode)

(global-set-key (kbd "C-c M-x")     'execute-extended-command) ; old M-x

(global-set-key (kbd "M-x")         'smex)
(global-set-key (kbd "M-X")         'smex-major-mode-commands)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)

(global-set-key (kbd "C-x f")       'find-file-in-repository)

(defun cos/join-lines ()
  (interactive)
  (join-line -1))
(global-set-key (kbd "C-M-j")         'cos/join-lines)

(defun cos/move-line-down ()
  (interactive)
  (let ((col (current-column)))
    (save-excursion
      (forward-line)
      (transpose-lines 1))
    (forward-line)
    (move-to-column col)))
(global-set-key (kbd "<C-S-down>")  'cos/move-line-down)

(defun cos/move-line-up ()
  (interactive)
  (let ((col (current-column)))
    (save-excursion
      (forward-line)
      (transpose-lines -1))
    (move-to-column col)))
(global-set-key (kbd "<C-S-up>")    'cos/move-line-up)

;; unmap upcase-region, since it always screws with undo
(global-unset-key (kbd "C-x C-u"))
