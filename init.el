(defvar emacs-dir (file-name-directory (file-chase-links load-file-name))
  "The giant turtle on which the world rests.")
(defvar cache-dir (substitute-in-file-name "~/.cache/emacs")
  "Cache directory for backups / auto-saves.")
(defvar misc-dir (substitute-in-file-name "~/.cache/emacs/misc")
  "Cache directory for misc. items.")
(defvar modes-dir (expand-file-name "modes" emacs-dir)
  "Modes configuration directory.")
(defvar packages-dir (expand-file-name "pkgs" cache-dir)
  "Separate packages directory.")
(defvar site-lisp-dir (expand-file-name "site-lisp" emacs-dir)
  "Site-lisp directory.")

(unless (file-exists-p cache-dir)
  (make-directory cache-dir t))
(unless (file-exists-p misc-dir)
  (make-directory misc-dir t))
(unless (file-exists-p packages-dir)
  (make-directory packages-dir))

(setq package-user-dir
      (expand-file-name "elpa" emacs-dir))

(defun set-exec-path-from-login-shell ()
  "Set `exec-path' and PATH variable from the user's login shell."
  (interactive)
  (let ((path-from-shell
         (replace-regexp-in-string
          "[ \t\n]*$" ""
          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

;; Add custom feature paths
(add-to-list 'load-path site-lisp-dir)
(dolist (f (directory-files site-lisp-dir))
  (let ((path (expand-file-name f site-lisp-dir)))
    (when (and (file-directory-p path)
               (not (string-prefix-p "." f)))
      (add-to-list 'load-path path))))


(require 'package)
(package-initialize)

;; Load configs with arbitrary names
(dolist (f (directory-files modes-dir))
  (let ((name (expand-file-name f modes-dir)))
    (when (and (file-regular-p name)
               (not (string-prefix-p "." f)))
      (load name))))

;; Shorter, but requires unique filenames---different from existing modes
;; (add-to-list 'load-path modes-dir)

;; Show either file or buffer name
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

(require 'keys-mode)
(require 'magit)
(setq inhibit-startup-screen t)
(define-key keys-mode-map (kbd "C-c m") 'magit-status)
(setq mac-command-modifier 'meta
      mac-option-modifier nil)

(when (>= emacs-major-version 24)
  (add-to-list
   'package-archives
   ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t))

(evil-mode t)

(defun toggle-evilmode ()
  (interactive)
  (if (bound-and-true-p evil-local-mode)
    (progn
      ; go emacs
      (evil-local-mode (or -1 1))
      (undo-tree-mode (or -1 1))
      (set-variable 'cursor-type 'bar)
    )
    (progn
      ; go evil
      (evil-local-mode (or 1 1))
      (set-variable 'cursor-type 'box)
    )
  )
)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'zenburn t)

(define-key isearch-mode-map (kbd "<down>") 'isearch-ring-advance)
(define-key isearch-mode-map (kbd "<up>") 'isearch-ring-retreat)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages
   (quote
    (atom-one-dark-theme atom-dark-theme doom-themes ensime web-mode highlight-parentheses counsel-projectile flycheck keystore-mode ## helm-projectile helm-descbinds zenburn-theme magit helm evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(menu-bar-mode -1) 
(tool-bar-mode -1) 
(toggle-scroll-bar -1) 

(require 'projectile)
(setq projectile-indexing-method 'alien)

(counsel-projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;; (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
;; (Define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; Show Paren
(require 'paren)
(setq show-paren-delay 0)
(show-paren-mode 1)                     ; highlight matching parentheses
(setq ensime-startup-notification nil)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.scss?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.xml?\\'" . web-mode))
(web-mode)


(add-hook 'web-mode-hook
  (lambda ()
  (if (equal web-mode-content-type "javascript")
  (web-mode-set-content-type "jsx")
  (message "now set to: %s" web-mode-content-type))))

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
)
(add-hook 'web-mode-hook  'my-web-mode-hook)
(setq-default electric-indent-inhibit t)

;; Set default font
(set-face-attribute 'default nil
                    :family "Hack"
                    :height 130
                    :weight 'normal
                    :width 'normal)

(require 'atom-one-dark-theme)
(load-theme 'atom-one-dark t)
