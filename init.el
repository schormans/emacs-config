
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
 '(TeX-engine 'luatex)
 '(anaconda-mode-localhost-address "localhost")
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes '(doom-gruvbox))
 '(custom-safe-themes
   '("6b1abd26f3e38be1823bd151a96117b288062c6cde5253823539c6926c3bb178" "d6603a129c32b716b3d3541fc0b6bfe83d0e07f1954ee64517aa62c9405a3441" default))
 '(display-line-numbers t)
 '(markdown-command "pandoc")
 '(org-image-actual-width nil)
 '(package-selected-packages
   '(elpy window-numbering zetteldeft deft doom-modeline helm buffer-move company-web web-mode beacon zone-nyan company-auctex doom-themes irony-eldoc company-reftex company-irony-c-headers company-irony company ein auctex))
 '(pyvenv-virtualenvwrapper-python "/Users/mjs/.pyenv/versions/3.10.11/bin/python3")
 '(pyvenv-workon "/Users/mjs/.pyenv/versions/3.10.11")
 '(tool-bar-mode nil)
 '(word-wrap t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#282828" :foreground "#e1e1e0" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 160 :width normal :foundry "nil" :family "IBM Plex Mono"))))
 '(italic ((t (:slant italic :weight light))))
 '(tool-bar ((t (:background "grey75" :foreground "black" :box (:line-width (1 . 1) :style released-button))))))


;;try using a doom theme
;;(load-theme 'doom-gruvbox t)

;;Manually load my scripts from ~/.emacs.d/.

(add-to-list 'load-path "~/.emacs.d/mylisp/")



;; Spectre mode stuff

(add-to-list 'load-path "~/.emacs.d/mylisp/emacs-netlist-modes/spectre-mode/")

;; (byte-compile-file "./mylisp/emacs-netlist-modes/spectre-mode/ntlst-aux.elc")
;; (byte-compile-file "./mylisp/emacs-netlist-modes/spectre-mode/ntlst-section.el")
;; (byte-compile-file "./mylisp/emacs-netlist-modes/spectre-mode/active-file.el")

(load "ntlst-aux.elc")
(load "ntlst-section.elc")
;; (load "active-file.elc")

(load "spectre-mode.elc")

(autoload 'spectre-mode "spectre-mode" "Spectre Editing Mode" t)
(setq auto-mode-alist (append (list (cons "\\.scs$" 'spectre-mode)
				       (cons "\\.inp$" 'spectre-mode))
				 auto-mode-alist))



;; SKILL mode
(load "skill-mode")
;;load paren-peek to see matching parentheses offscreen
					;(load-file "~/.emacs.d/paren-peek.el")
(load "paren-peek")

;;package stuff from petersen

(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
	;;	("marmalade" . "http://marmalade-repo.org/packages/")
	;;rip in pepperonis marmalade
	("melpa" . "http://melpa.org/packages/")))

;;use-package

(eval-when-compile
  (require 'use-package))

;;my basic edits

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
(setq reftex-allow-automatic-rescan t
      reftex-enable-partial-scans t
      reftex-save-parse-info t
      reftex-use-multiple-selection-buffers t)
(setq font-latex-fontify-script nil) ;don't piss about with super and subscripts.

;;doom-modeline
;;if there are issues with this, do:
;; M-x all-the-icons-install-fonts
;;to ensure that the fonts that are required are downloaded and installed
(use-package all-the-icons)
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))


;;Helm configuration. Do a little config here, taking some inspiration from Matheus https://github.com/matman26/emacs-config

(use-package helm
  :init
    (require 'helm-config)
    (setq helm-split-window-in-side-p t
          helm-move-to-line-cycle-in-source t)
  :config 
    (helm-mode 1) ;; Most of Emacs prompts become helm-enabled
    (helm-autoresize-mode 1) ;; Helm resizes according to the number of candidates
    (global-set-key (kbd "C-x b") 'helm-buffers-list) ;; List buffers ( Emacs way )
    (global-set-key (kbd "C-x r b") 'helm-bookmarks) ;; Bookmarks menu
    (global-set-key (kbd "C-x C-f") 'helm-find-files) ;; Finding files with Helm
    (global-set-key (kbd "M-c") 'helm-calcul-expression) ;; Use Helm for calculations
    (global-set-key (kbd "C-s") 'helm-occur)  ;; Replaces the default isearch keybinding
    (global-set-key (kbd "C-h a") 'helm-apropos)  ;; Helmized apropos interface
    (global-set-key (kbd "M-x") 'helm-M-x)  ;; Improved M-x menu
    (global-set-key (kbd "M-y") 'helm-show-kill-ring)  ;; Show kill ring, pick something to paste
  :ensure t)

;;deft and zetteldeft
;;setting default deft extension to org, likely just want .org zettels?

(use-package deft
  :ensure t
  :bind ("<f8>" . deft)
  :commands (deft)
  :config (setq deft-directory "~/ownCloud/deft"
		deft-extensions '("md" "org" "tex" "txt")
		deft-recursive t
		deft-default-extension "org"
		deft-use-filter-string-for-filename t
		deft-file-naming-rules '((noslash . "-")
					 (nospace . "-")
					 (case-fn . downcase))))

(use-package zetteldeft
  :ensure t
  :after deft
  :config (zetteldeft-set-classic-keybindings))


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

(use-package elpy
  :ensure t
  :init (elpy-enable))

;; (use-package company-jedi
;; 	     :ensure t
;; 	     :config
;; 	     (add-hook 'python-mode-hook 'jedi:setup))

;; (require 'pyenv-mode)

(use-package company-reftex
  :after company
  :ensure t
  :config
  (add-to-list 'company-backends 'company-reftex-citations)
  (add-to-list 'company-backends 'company-reftex-labels)
  (add-hook 'LaTeX-mode-hook 'company-reftex-citations)
  (add-hook 'LaTeX-mode-hook 'company-reftex-labels)
  )

(defun which-active-modes ()
  "Return a list of which minor modes are enabled in the current buffer."
  (interactive)
  (let ((active-modes))
    (mapc (lambda (mode) (condition-case nil
                             (if (and (symbolp mode) (symbol-value mode))
                                 (add-to-list 'active-modes mode))
                           (error nil) ))
          minor-mode-list)
    active-modes))

(defun my/reftex-after-save-fun ()
  ;;this func is to be run after saving, check if reftex-mode is active, if so, refresh reference db
  (if (member 'reftex-mode (which-active-modes)) (reftex-reset-mode) nil))

(add-hook 'after-save-hook 'my/reftex-after-save-fun)

(use-package company-auctex
  :after company
  :ensure t
  :config
  (add-to-list 'company-backends 'company-auctex))

(defun my/python-mode-hook ()
  ;; (add-to-list 'company-backends 'company-jedi)
  ;; (add-to-list 'company-backends 'company-anaconda)
  ;; (pyenv-mode)
  (lambda ()
    (setq-default indent-tabs-mode nil)
    (setq-default tab-width 4)
    (setq-default python-indent 4)))

;; (add-hook 'python-mode-hook 'anaconda-mode)
;; (add-hook 'python-mode-hook 'anaconda-eldoc-mode)
(add-hook 'python-mode-hook 'my/python-mode-hook)


(use-package company-web
  :ensure t
  :config
  (add-to-list 'company-backends 'company-web-html)
  (add-to-list 'company-backends 'company-web-jade)
  (add-to-list 'company-backends 'company-web-slim)
  )

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))


;;highlight matching tags in web mode

(defun my/web-mode-hook ()
  (setq web-mode-enable-current-element-highlight t))


(add-hook 'web-mode-hook 'my/web-mode-hook)

;;org-mode configuration

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(setq org-log-done t)
(setq org-startup-folded nil) ;don't fold everything up by default
(setq org-startup-truncated nil) ;don't overwrite word wrap setting, tables be damned
(add-hook 'org-mode-hook 'org-indent-mode) ;indentation for org sections etc
(setq org-return-follows-link t) ;when in org-mode, hit RET to follow a link instead of C-c C-o

(eval-after-load "org"
  '(require 'ox-md nil t))

(eval-after-load "company"
  '(add-to-list 'company-backends 'company-anaconda))

;;beacon-mode

(beacon-mode 1) ;enable all the time

;;window-numbering-mode

(window-numbering-mode 1) ;enable all the time


;; override inane apple defaults for home and end
(global-set-key (kbd "<home>") 'beginning-of-line)
(global-set-key (kbd "<end>") 'end-of-line)


;; Fix company-dabbrev lowercase meme?
(setq company-dabbrev-downcase nil)
(setq company-dabbrev-ignore-case nil)

;;buffer-move keybindings

;; (require 'buffer-move)

;; (global-set-key (kbd "<C-S-up>")    'buf-move-up)
;; (global-set-key (kbd "<C-S-down>")  'buf-move-down)
;; (global-set-key (kbd "<C-S-left>")  'buf-move-left)
;; (global-set-key (kbd "<C-S-right>") 'buf-move-right)

(require 'tramp)
