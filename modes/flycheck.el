;;; flycheck --- configuration

;;; Commentary:

;;; Code:

(require 'flycheck)

(when (fboundp 'define-fringe-bitmap)
  (define-fringe-bitmap 'my-flycheck-fringe-indicator
    (vector #b00000000
            #b00000000
            #b00000000
            #b00000000
            #b00000000
            #b00000000
            #b00000000
            #b00011100
            #b00111110
            #b00111110
            #b00111110
            #b00011100
            #b00000000
            #b00000000
            #b00000000
            #b00000000
            #b00000000)))

(flycheck-define-error-level 'error
  :overlay-category 'flycheck-error-overlay
  :fringe-bitmap 'my-flycheck-fringe-indicator
  :fringe-face 'flycheck-fringe-error)

(flycheck-define-error-level 'warning
  :overlay-category 'flycheck-warning-overlay
  :fringe-bitmap 'my-flycheck-fringe-indicator
  :fringe-face 'flycheck-fringe-warning)

(flycheck-define-error-level 'info
  :overlay-category 'flycheck-info-overlay
  :fringe-bitmap 'my-flycheck-fringe-indicator
  :fringe-face 'flycheck-fringe-info)

(set-face-attribute 'flycheck-error nil :underline "Red")
(set-face-attribute 'flycheck-warning nil :underline "Orange")

(setq-default flycheck-emacs-lisp-load-path 'inherit)
(setq flycheck-check-syntax-automatically '(mode-enable save))
(setq flycheck-global-modes '(not elfeed-search-mode))

(global-flycheck-mode 1)                ; enable flycheck when appropriate

;;; flycheck.el ends here
