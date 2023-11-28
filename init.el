;;; Use at your own risk - Hassan Alsheikh


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; PACKAGE MANAGER - MELPA;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
;; Install use-package if it's not already installed
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; END OF PACKAGE MANAGER - MELPA ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;; Use use-package for package management;
(require 'use-package)



;;;;;;;;;;;;;;;
;;; TREEMCS ;;;
;;;;;;;;;;;;;;;
(use-package treemacs
  :ensure t
  :defer t
  :config
  (with-eval-after-load 'treemacs
    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t))
  :bind
  (:map global-map
        ([f8]        . treemacs)
        ("C-<f8>"    . treemacs-select-window)
        ("s-e"       . treemacs))) ; Replace "s-e" with your desired key binding

;;;  Treemacs will start with hidden files turned off by default. If you ever need to see hidden files again, you can use the t h toggle inside Treemacs to make them visible.
(setq treemacs-show-hidden-files nil)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;END OF TREEMACS Custom Configuragtions;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;
;;; HELM ;;;
;;;;;;;;;;;;
(use-package helm
  :ensure t
  :defer t
  :bind (("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x b" . helm-buffers-list)
         :map helm-map
         ("<tab>" . helm-execute-persistent-action) ; rebind tab to run persistent action
         ("C-i" . helm-execute-persistent-action) ; make TAB work in terminal
         ("C-z" . helm-select-action)) ; list actions using C-z
  :config
  (helm-mode 1))
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; END OF HELM CONFIG ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;



;;; Setup the Emacs PATH: Ensure that Emacs uses the same PATH as your shell
(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))


;;;;;;;;;;;;;;;;
;;; org-roam ;;;
;;;;;;;;;;;;;;;;
(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/Documents/00 - Inbox/"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ("C-c n j" . org-roam-dailies-capture-today))) ;; Dailies
;;;;;;;;;;;;;;;;;;;;;;
;;; END OF ORG ROAM;;;
;;;;;;;;;;;;;;;;;;;;;;



;;; bidirtion - rtl ltr
(setq bidi-display-reordering t)



;;; adding delimiters and running it when emacs starts
(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))



;; global visual line mode
(global-visual-line-mode t)



;;;;;;;;;;;;;;;;;;;;
;;; COMPNAY MODE ;;;
;;;;;;;;;;;;;;;;;;;;
(use-package company
  :ensure t
  :init
  :config (add-hook 'after-init-hook 'global-company-mode)
  (global-company-mode))
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; END OF COMPANY MODE;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;
;;; LSP-MODE ;;;
;;;;;;;;;;;;;;;;
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook ((lisp-mode . lsp-deferred)
	 (python-mode . lsp-deferred)
         (c-mode . lsp-deferred)
         (c++-mode . lsp-deferred)
         (ruby-mode . lsp-deferred)
         (rust-mode . lsp-deferred)
         (zig-mode . lsp-deferred)
         (js-mode . lsp-deferred)
         (typescript-mode . lsp-deferred)
         (html-mode . lsp-deferred)
         (css-mode . lsp-deferred)
         (swift-mode . lsp-deferred))
  :init
  (setq lsp-enable-file-watchers nil)
  :config
  (setq lsp-prefer-flymake nil))  ; Use flycheck or lsp-ui for error checking if available

;; Optionally, install and enable lsp-ui for additional features
;; (e.g., code navigation, inline documentation, etc.)
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

;; Tailwind CSS specific setup (if required)
(use-package lsp-tailwindcss
  :after lsp-mode
  :hook (css-mode . lsp-tailwindcss-enable))

(require 'lsp-mode)

;; Additional lsp-mode configurations
(setq lsp-enable-file-watchers nil)
(setq lsp-log-io nil)
(setq lsp-prefer-flymake nil)  ; Use flycheck instead of flymake

;; Optional: lsp-ui for additional UI features
(when (require 'lsp-ui nil 'noerror)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

;; Optional: company-mode for autocompletion
(when (require 'company nil 'noerror)
  (add-hook 'lsp-mode-hook 'company-mode))

;; Tailwind CSS specific setup
(when (require 'lsp-tailwindcss nil 'noerror)
  (add-hook 'css-mode-hook 'lsp-tailwindcss-enable))
;;;;;;;;;;;;;;;;;;;;;;;
;;; END OF LSP-MODE ;;;
;;;;;;;;;;;;;;;;;;;;;;;



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(connection-local-criteria-alist
   '(((:application tramp :machine "MacStudio.local")
      tramp-connection-local-darwin-ps-profile)
     ((:application tramp :protocol "flatpak")
      tramp-container-connection-local-default-flatpak-profile)
     ((:application tramp :machine "localhost")
      tramp-connection-local-darwin-ps-profile)
     ((:application tramp :machine "mltg01os10248w")
      tramp-connection-local-darwin-ps-profile)
     ((:application tramp)
      tramp-connection-local-default-system-profile tramp-connection-local-default-shell-profile)))
 '(connection-local-profile-alist
   '((tramp-container-connection-local-default-flatpak-profile
      (tramp-remote-path "/app/bin" tramp-default-remote-path "/bin" "/usr/bin" "/sbin" "/usr/sbin" "/usr/local/bin" "/usr/local/sbin" "/local/bin" "/local/freeware/bin" "/local/gnu/bin" "/usr/freeware/bin" "/usr/pkg/bin" "/usr/contrib/bin" "/opt/bin" "/opt/sbin" "/opt/local/bin"))
     (tramp-connection-local-darwin-ps-profile
      (tramp-process-attributes-ps-args "-acxww" "-o" "pid,uid,user,gid,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" "-o" "state=abcde" "-o" "ppid,pgid,sess,tty,tpgid,minflt,majflt,time,pri,nice,vsz,rss,etime,pcpu,pmem,args")
      (tramp-process-attributes-ps-format
       (pid . number)
       (euid . number)
       (user . string)
       (egid . number)
       (comm . 52)
       (state . 5)
       (ppid . number)
       (pgrp . number)
       (sess . number)
       (ttname . string)
       (tpgid . number)
       (minflt . number)
       (majflt . number)
       (time . tramp-ps-time)
       (pri . number)
       (nice . number)
       (vsize . number)
       (rss . number)
       (etime . tramp-ps-time)
       (pcpu . number)
       (pmem . number)
       (args)))
     (tramp-connection-local-busybox-ps-profile
      (tramp-process-attributes-ps-args "-o" "pid,user,group,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" "-o" "stat=abcde" "-o" "ppid,pgid,tty,time,nice,etime,args")
      (tramp-process-attributes-ps-format
       (pid . number)
       (user . string)
       (group . string)
       (comm . 52)
       (state . 5)
       (ppid . number)
       (pgrp . number)
       (ttname . string)
       (time . tramp-ps-time)
       (nice . number)
       (etime . tramp-ps-time)
       (args)))
     (tramp-connection-local-bsd-ps-profile
      (tramp-process-attributes-ps-args "-acxww" "-o" "pid,euid,user,egid,egroup,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" "-o" "state,ppid,pgid,sid,tty,tpgid,minflt,majflt,time,pri,nice,vsz,rss,etimes,pcpu,pmem,args")
      (tramp-process-attributes-ps-format
       (pid . number)
       (euid . number)
       (user . string)
       (egid . number)
       (group . string)
       (comm . 52)
       (state . string)
       (ppid . number)
       (pgrp . number)
       (sess . number)
       (ttname . string)
       (tpgid . number)
       (minflt . number)
       (majflt . number)
       (time . tramp-ps-time)
       (pri . number)
       (nice . number)
       (vsize . number)
       (rss . number)
       (etime . number)
       (pcpu . number)
       (pmem . number)
       (args)))
     (tramp-connection-local-default-shell-profile
      (shell-file-name . "/bin/sh")
      (shell-command-switch . "-c"))
     (tramp-connection-local-default-system-profile
      (path-separator . ":")
      (null-device . "/dev/null"))))
 '(custom-enabled-themes '(dracula))
 '(custom-safe-themes
   '("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "8c7e832be864674c220f9a9361c851917a93f921fedb7717b1b5ece47690c098" "c517e98fa036a0c21af481aadd2bdd6f44495be3d4ac2ce9d69201fcb2578533" "014cb63097fc7dbda3edf53eb09802237961cbb4c9e9abd705f23b86511b0a69" "603a831e0f2e466480cdc633ba37a0b1ae3c3e9a4e90183833bc4def3421a961" "944d52450c57b7cbba08f9b3d08095eb7a5541b0ecfb3a0a9ecd4a18f3c28948" "c865644bfc16c7a43e847828139b74d1117a6077a845d16e71da38c8413a5aaa" "adaf421037f4ae6725aa9f5654a2ed49e2cd2765f71e19a7d26a454491b486eb" "f681100b27d783fefc3b62f44f84eb7fa0ce73ec183ebea5903df506eb314077" default))
 '(global-display-line-numbers-mode t)
 '(package-selected-packages
   '(smartparens treemacs-nerd-icons major-mode-icons helm-icons all-the-icons-completion treemacs-all-the-icons all-the-icons-nerd-fonts all-the-icons doom-modeline emmet-mode smart-tab ruby-extra-highlight undo-tree enh-ruby-mode ruby-tools treemacs rubocop yaml-mode magit robe rspec-mode projectile-rails org-modern rainbow-mode emacsql-sqlite org-roam-bibtex org-roam-ui org-roam-timestamps cmake-mode vterm eat org-roam rainbow-delimiters neotree web-mode async zig-mode pdf-tools all-the-icons-dired lsp-python-ms which-key yasnippet projectile lsp-tailwindcss helm-mode-manager flycheck ace-window pfuture cfrs hydra lsp-ui dracula-theme helm-lsp lsp-julia dap-mode company lsp-ivy)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )




;;;;;;;;;;;;;;;;;
;; this is GPT configurariton
;;;;;;;;;;;;;;;;;


;;; Enhanced Ruby Mode: For better syntax highlighting, you can use enh-ruby-mode.
(use-package enh-ruby-mode
  :ensure t
  :mode ("\\.rb\\'" "\\.ru\\'" "Rakefile\\'" "Gemfile\\'" "Vagrantfile\\'")
  :interpreter "ruby")



;;; Projectile for Project Management: Projectile helps manage and navigate projects in Emacs:
(use-package projectile
  :ensure t
  :config
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
	      ("C-c p" . projectile-command-map)))



;;; Ruby on Rails Support: The projectile-rails package integrates with Projectile for navigating Rails projects:
(use-package projectile-rails
  :ensure t
  :after projectile
  :config
  (projectile-rails-global-mode))



;;; RSpec Mode: For testing with RSpec, use the rspec-mode:
(use-package rspec-mode
  :ensure t
  :config
  (setq rspec-use-spring-when-possible t))



;;; Robe for Code Navigation and Documentation: robe starts a Ruby REPL inside Emacs and can be used for code navigation, documentation lookup, and completion.
(use-package robe
  :ensure t
  :hook (ruby-mode . robe-mode)
  :config
  (eval-after-load 'company
    '(push 'company-robe company-backends)))


  
;;; Magit for Git Integration: Magit is an interface to the version control system Git, integrated into Emacs:
(use-package magit
  :ensure t)



;;; YAML Mode: Since .yml files are common in Rails applications, you might want to install yaml-mode:
(use-package yaml-mode
  :ensure t
  :mode ("\\.yml\\'" "\\.yaml\\'"))



;;;Flycheck for On-the-Fly Syntax Checking:
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))



;;; Snippets and Templates: Use yasnippet for code snippets in Ruby and Rails files:
(use-package yasnippet
  :ensure t
  :init
  :config
  (yas-global-mode 1))



(use-package which-key
  :ensure t
  :config
  (which-key-mode))



;;;;;;;;;;;;;;;;;
;;; Undo Tree ;;;
;;;;;;;;;;;;;;;;;
(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode 1))
;;;;;;;;;;;;;;;;;;;;;;;;
;;; END OF UNDO TREE ;;;
;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;
;;; Web-Mode ;;;
;;;;;;;;;;;;;;;;
(use-package web-mode
  :ensure t
  :mode (("\\.erb\\'" . web-mode)
         ("\\.eex\\'" . web-mode)
	 ("\\.html?\\'" . web-mode)
         ("\\.css\\'" . web-mode)
         ("\\.js\\'" . web-mode)
         ("\\.ts\\'" . web-mode)
         ("\\.jsx?\\'" . web-mode)
         ("\\.tsx?\\'" . web-mode)
	 )
  :config
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-auto-close-style 2)  ; Auto-close tags
  (setq web-mode-enable-auto-quoting t)  ; Auto-quote attribute values
  (setq web-mode-markup-indent-offset 2)  ; HTML indentation
  (setq web-mode-css-indent-offset 2)     ; CSS indentation
  (setq web-mode-code-indent-offset 2)    ; Script indentation (JS, PHP, etc.)
  (setq web-mode-enable-css-colorization t)
  )
;;;;;;;;;;;;;;;;;;;;;;;
;;; END OF WEB-MODE ;;;
;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;
;;; EMMET ;;;
;;;;;;;;;;;;;
(use-package emmet-mode
  :ensure t
  :hook (web-mode . emmet-mode))  ; Enable emmet-mode in web-mode
;;;;;;;;;;;;;;;;;;;;;;;;;
;;; END OF EMMET MODE ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;
;;; Smart TAB ;;; i am still testing this i might remove it.
;;;;;;;;;;;;;;;;;
(use-package smart-tab
  :ensure t
  :config
  (global-smart-tab-mode 1))
;;;;;;;;;;;;;;;;;;;;;;;;
;;; END OF SMART TAB ;;;
;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;
;;; SMART PARENS ;;;
;;;;;;;;;;;;;;;;;;;;
(use-package smartparens-mode
  :ensure smartparens
  :hook (prog-mode text-mode markdown-mode)
  :config
  (require 'smartparens-config))
;;;;;;;;;;;;;;;;;;;;;;;;
;;; END SMART PARENS ;;;
;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ALL THE ICONS & Fonts ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package all-the-icons
  :ensure t
  :config
  ;; Check if fonts are already installed; install them if not
  (unless (member "all-the-icons" (font-family-list))
    (all-the-icons-install-fonts t)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; END OF ALL THE ICONS & Fonts ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;
;;; Doom Mode Line ;;;
;;;;;;;;;;;;;;;;;;;;;;
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; END OF Doom Mode Line ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; KEYBINDINGS & SHORTCODES ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; SAVE
(global-set-key (kbd "s-s") 'save-buffer)

;;; PASTE
(global-set-key (kbd "s-v") 'yank)

;;; Beginning of buffer
(global-set-key (kbd "s-<up>") 'beginning-of-buffer)

;;; End of buffer
(global-set-key (kbd "s-<down>") 'end-of-buffer)

;;; Kill buffer with Command-w
(global-set-key (kbd "s-w") 'kill-buffer)

;;; Undo
(global-set-key (kbd "s-z") 'undo-tree-undo)

;;; Redo
(global-set-key (kbd "s-r") 'undo-tree-redo)

;;; Execute Extended Command from M-x to s-p using Helm
(global-set-key (kbd "s-p") 'helm-M-x)

;;; Open file from C-x C-f to s-o
(global-set-key (kbd "s-o") 'helm-find-files)

;;; Buffer list
(global-set-key (kbd "s-b") 'helm-buffers-list)
(global-set-key (kbd "s-<kp-0>") 'helm-buffers-list)

;;; Search text in the opened file from C-s to s-f
(global-set-key (kbd "s-f") 'isearch-forward)

;;; Start The Terminal (Eshell)
(global-set-key (kbd "s-t") 'eshell)

;;; Default font size to 19
(set-face-attribute 'default nil :height 190)

;;; C-Tab go to next buffer C-Shit-Tab go to previouse buffer
(global-set-key (kbd "C-<tab>") 'next-buffer)
(global-set-key (kbd "C-S-<tab>") 'previous-buffer)

;;; init.el ends here
