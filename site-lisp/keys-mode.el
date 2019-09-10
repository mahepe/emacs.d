;;; keys-mode.el --- configuration

;;; Commentary:

;;; Code:

(defvar keys-mode-map (make-sparse-keymap)
  "Keymap for `keys-mode'.")

;;;###autoload
(define-minor-mode keys-mode
    "Custom global keybindings."
  :init-value t
  :lighter " keys"
  :keymap keys-mode-map)

;;;###autoload
(define-globalized-minor-mode global-keys-mode keys-mode keys-mode)

;; Override most other modes
(add-to-list 'emulation-mode-map-alists `((keys-mode . ,keys-mode-map)))

(defun disable-keys-mode ()
  "Disable keys-mode."
  (keys-mode -1))

(add-hook 'minibuffer-setup-hook #'disable-keys-mode)

;; (add-hook 'prog-mode-hook 'keys-mode)
;; (add-hook 'text-mode-hook 'keys-mode)

(define-key keys-mode-map (kbd "C-.") 'repeat)
(define-key keys-mode-map (kbd "C-+") 'text-scale-increase)
(define-key keys-mode-map (kbd "C-x m") 'eshell)
(define-key keys-mode-map (kbd "M-/") 'hippie-expand)
;; (define-key keys-mode-map (kbd "M-n") 'scroll-up-line)
;; (define-key keys-mode-map (kbd "M-p") 'scroll-down-line)

(provide 'keys-mode)

;;; keys-mode.el ends here
