;;; helm.el --- configuration

;;; Commentary:

;;; Code:

(require 'helm)
(require 'helm-config)
(require 'helm-descbinds)
(require 'helm-projectile)

;; (defvar helm-always-two-windows t)
;; (defvar helm-mode-line-string "")

(defvar helm-M-x-fuzzy-match t)
(defvar helm-apropos-fuzzy-match t)
(defvar helm-imenu-fuzzy-match t)
(defvar helm-lisp-fuzzy-completion t)
(defvar helm-recentf-fuzzy-match t)
(defvar helm-semantic-fuzzy-match t)
(setq helm-buffers-fuzzy-matching t)
(setq helm-display-header-line nil)
(setq helm-ff-file-name-history-use-recentf t)
(setq helm-ff-search-library-in-sexp t)
(setq helm-move-to-line-cycle-in-source t)
(setq helm-split-window-inside-p t)
(setq projectile-completion-system 'helm)
(setq projectile-switch-project-action 'helm-projectile)

(when (executable-find "ack")
  (setq helm-grep-default-command
        "ack -Hn --color --smart-case --no-group %e %p %f")
  (setq helm-grep-default-recurse-command
        "ack -H --color --smart-case --no-group %e %p %f"))

(when (executable-find "rg")
  (setq helm-grep-ag-command
        "rg -Sn --color never --no-heading %s %s %s"))

;; Mode

(when (fboundp 'helm-autoresize-mode)
  (helm-autoresize-mode t))

(helm-mode 1)
(helm-descbinds-mode)
(helm-projectile-on)

;; Key Bindings
(define-key helm-command-map (kbd "SPC") 'helm-all-mark-rings)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z") 'helm-select-action)

(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p s s") 'helm-projectile-ack)

(global-unset-key (kbd "C-x c"))

(global-set-key (kbd "C-c a") 'helm-do-grep-ag)
(global-set-key (kbd "C-c f") 'helm-recentf)
(global-set-key (kbd "C-c g") 'helm-grep-do-git-grep)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-set-key (kbd "C-c o") 'helm-occur)
(global-set-key (kbd "C-h a") 'helm-apropos)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

;;; helm.el ends here
