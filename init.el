(setq frame-title-format "%b")

(setq inhibit-startup-message t
      initial-scratch-message ""
      make-backup-files nil
      line-spacing 3
      indent-tabs-mode nil
      auto-revert-verbose nil)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode 1)
(show-paren-mode 1)

(setq custom-file "~/.emacs.d/custom-file.el")
(when (file-exists-p custom-file)
  (load-file custom-file))

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(require 'package)
(package-initialize)
(setq url-http-attempt-keepalives nil)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(use-package ido
  :config
  (setq ido-auto-merge-work-directories-length -1)
  (ido-mode 1))

(use-package company
  :ensure t
  :config
  (setq company-minimum-prefix-length 2
	company-idle-delay 0.5)
  (global-company-mode t))

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

(use-package ace-window
  :bind ("M-o" . ace-window))

(use-package dired
  :config
  (setq dired-recursive-deletes 'always
	dired-recursive-copies 'always
	dired-listing-switches "-hal --group-directories"
	dired-omit-files "^\\.[#?[:alnum:]+]"
	dired-use-ls-dired t)
  :hook
  ((dired-mode . dired-omit-mode)
   (dired-mode . auto-revert-mode)))

(use-package dired+
  :load-path "~/.emacs.d/diredplus"
  :config
  (diredp-toggle-find-file-reuse-dir 1)
  :custom-face
  (diredp-compressed-file-suffix ((t (:foreground "orange")))))

(use-package neotree
  :config
  (setq neo-window-width 30
	neo-theme 'ascii)
  :bind ("<f8>" . neotree-toggle))

(use-package winner
  :config
  (winner-mode 1))

(use-package c-mode
  :preface
  (defun my-c-mode-hook ()
    (hide-ifdef-mode)
    (smartparens-mode)
    (eldoc-mode)
    (electric-pair-mode))
  :config
  (setq c-basic-offset 4
	c-syntactic-indentation-in-macros nil)
  :hook (c-mode . my-c-mode-hook))
