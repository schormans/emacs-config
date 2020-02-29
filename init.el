
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-engine (quote luatex))
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (misterioso)))
 '(display-line-numbers t)
 '(package-selected-packages
   (quote
    (company-auctex doom-themes irony-eldoc company-reftex company-jedi company-irony-c-headers company-irony company ein auctex)))
 '(word-wrap t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#2d3743" :foreground "#e1e1e0" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :family "Inconsolata")))))


;;try using a doom theme
(load-theme 'doom-gruvbox t)

;;load paren-peek to see matching parentheses offscreen
(load-file "~/.emacs.d/paren-peek.el")

;;package stuff from petersen

(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
	;;	("marmalade" . "http://marmalade-repo.org/packages/")
	;;rip in pepperonis marmalade
	("melpa" . "http://melpa.milkbox.net/packages/")))

;;use-package

(eval-when-compile
  (require 'use-package))

;;my edits

(show-paren-mode 1)
(setq inhibit-startup-message t)
(global-unset-key (kbd "C-z")) ;do this to stop me being asshat and trying to undo with wrong keybind
(setq TeX-save-query nil)
(delete-selection-mode 1)
(desktop-save-mode 1)
(electric-pair-mode 1)
(setq make-backup-files nil)

;;trying some latex shit

(require 'reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-parse-self t) ;enable parse on load
(setq TeX-auto-save t) ;enable parse on save

;;company autocomplete settings
;much of this is copied from cestlaz.github.io

(use-package company
	     :ensure t
	     :config
	     (setq company-idle-delay 0)
	     (setq company-minimum-prefix-length 3)
	     (global-company-mode t))

(use-package company-irony
	     :ensure t
	     :config
	     (add-to-list 'company-backends 'company-irony))

(use-package irony
	     :ensure t
	     :config
	     (add-hook 'c++-mode-hook 'irony-mode)
	     (add-hook 'c-mode-hook 'irony-mode)
	     (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(use-package irony-eldoc
	     :ensure t
	     :config
	     (add-hook 'irony-mode-hook #'irony-eldoc))

(use-package company-jedi
	     :ensure t
	     :config
	     (add-hook 'python-mode-hook 'jedi:setup))

(use-package company-reftex
  :after latex auctex company
  :ensure t
  :config
  (add-to-list 'company-backends 'company-reftex-citations)
  (add-to-list 'company-backends 'company-reftex-labels)
  ;(add-hook 'LaTeX-mode-hook 'company-reftex-citations)
  ;(add-hook 'LaTeX-mode-hook 'company-reftex-labels)
  )


(use-package company-auctex
  :after latex auctex company
  :ensure t
  :config
  (add-to-list 'company-backends 'company-auctex))

(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'my/python-mode-hook)

