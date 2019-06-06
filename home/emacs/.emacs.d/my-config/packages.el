(use-package base16-theme
  :config
  (load-theme 'base16-tomorrow-night t)
  (defun my/get-color (base)
    (plist-get base16-tomorrow-night-colors base))
  (modify-face 'trailing-whitespace (my/get-color :base00) (my/get-color :base08))
  (modify-face 'line-number-current-line (my/get-color :base05) (my/get-color :base00) nil t)
  (modify-face 'line-number (my/get-color :base04) (my/get-color :base00)))
(use-package company
  :after evil
  :config
  (global-company-mode 1)
  (setq company-idle-delay 0)
  (evil-define-key 'insert 'company-mode-hook (kbd "C-n") 'company-select-next-if-tooltip-visible-or-complete-selection)
  (evil-define-key 'insert 'company-mode-hook (kbd "C-p") 'company-select-previous))
(use-package company-auctex)
(use-package company-lsp)
(use-package counsel
  :demand t
  :bind (("C-c f" . counsel-imenu)
         ("C-c i" . counsel-info-lookup-symbol))
  :config
  (counsel-mode 1))
(use-package direnv
  :config
  (direnv-mode 1))
(use-package dockerfile-mode
  :mode "Dockerfile\\'")
(use-package edit-server ;; https://www.emacswiki.org/emacs/Edit_with_Emacs
  :config
  (setq edit-server-new-frame nil)
  (edit-server-start))
(use-package evil
  :init
  (setq-default evil-want-keybinding nil)
  (setq-default evil-want-C-u-scroll t)
  (setq-default evil-search-module 'evil-search)
  (setq-default evil-ex-search-persistent-highlight nil)
  :config
  (evil-mode 1)
  (global-undo-tree-mode -1)
  (evil-global-set-key 'normal "gt" 'switch-to-buffer)
  (evil-global-set-key 'normal "gcc" 'comment-or-uncomment-region)
  (evil-global-set-key 'normal "gcw" 'delete-trailing-whitespace)
  (evil-global-set-key 'normal "D" (lambda () (interactive)
                                     (beginning-of-line)
                                     (kill-line)))

  ;; Disable search after duration
  (defvar my/stop-hl-timer-last nil)
  (defun my/stop-hl-timer (_)
    (when my/stop-hl-timer-last
      (cancel-timer my/stop-hl-timer-last))
    (setq my/stop-hl-timer-last
          (run-at-time 1 nil (lambda () (evil-ex-nohighlight)))))
  (advice-add 'evil-ex-search-activate-highlight :after 'my/stop-hl-timer))
(use-package evil-args
  :after evil
  :config
  (define-key evil-inner-text-objects-map "a" 'evil-inner-arg)
  (define-key evil-outer-text-objects-map "a" 'evil-outer-arg))
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))
(use-package evil-easymotion
  :after evil
  :config
  (evilem-default-keybindings "SPC"))
(use-package evil-magit
  :after evil
  :bind ("C-c g" . magit-status)
  :demand t)
(use-package evil-surround
  :config
  (global-evil-surround-mode 1))
(use-package flycheck
  :hook (lsp-ui-mode . flycheck-mode))
(use-package htmlize) ;; For org mode
(use-package ivy
  :config
  (ivy-mode 1))
(use-package json-mode
  :mode "\\.json\\'")
(use-package lsp-mode
  :hook ((nix-mode python-mode rust-mode) . lsp)
  :config
  (setq lsp-prefer-flymake nil)
  (setq lsp-auto-guess-root t))
(use-package lsp-ui
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-max-width 50)
  (lsp-ui-doc-max-height 20))
(use-package neotree
  :bind ("C-c t" . neotree-toggle)
  :custom ((neo-smart-open t)
           (neo-show-hidden-files t))
  :config
  (add-hook 'neotree-mode-hook (defun neotree-hook ()
                            (display-line-numbers-mode -1)))
  (advice-add 'neo-open-file :after
              (defun my/neotree-open (_orig &rest _args)
                  (neotree-hide))))
(use-package nix-mode
  :after lsp-mode
  :mode "\\.nix\\'"
  :config
  (add-to-list 'lsp-language-id-configuration '(nix-mode . "nix"))
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("nix-lsp"))
                    :major-modes '(nix-mode)
                    :server-id 'nix))
  (define-key nix-mode-map (kbd "<tab>") (lambda () (interactive) (insert "  ")))
  (define-key nix-mode-map (kbd "C-x C-e") (lambda (start end)
                                             (interactive "r")
                                             (shell-command-on-region start end "nix-instantiate --eval -"))))
(use-package org)
(use-package powerline
  :config
  (powerline-center-evil-theme))
(use-package projectile
  :custom (projectile-completion-system 'ivy)
  :config
  (projectile-mode 1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))
(use-package ranger
  :bind ("C-c r" . ranger)
  :custom ((ranger-override-dired 'ranger)
           (ranger-override-dired-mode t)))
(use-package rust-mode
  :mode "\\.rs\\'"
  :config
  (add-hook 'rust-mode-hook (lambda () (my/set-compile "cargo check"))))
(use-package sublimity
  :config
  (require 'sublimity-scroll)
  (sublimity-mode 1))
(use-package tex
  :ensure auctex ; I have no idea why using use-package auctex does not work
  :pin gnu)
(use-package yaml-mode
  :mode "\\.yml\\'")
