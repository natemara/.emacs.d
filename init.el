(if (>= emacs-major-version 24)
    (message "")
  (load "~/.emacs.d/oldemacs.el"))

(let ((default-directory "~/.emacs.d/plugins/"))
  (normal-top-level-add-subdirs-to-load-path))

(load "~/.emacs.d/functions.el")
(package-initialize)

(load "~/.emacs.d/packages.el")
(load "~/.emacs.d/evil-config.el")

(setq-default ispell-program-name "aspell")

(global-evil-surround-mode 1)

(ido-mode t)

;;;;CONFIGS
; use tabs instead of spaces

(defun indent-defaults ()
  (setq indent-tabs-mode t)
  (setq tab-width 4)
  )

(add-hook 'python-mode-hook 'indent-defaults)
;(add-hook 'java-mode-hook 'indent-defaults)
;(add-hook 'c++-mode-hook 'indent-defaults)
;(add-hook 'c-mode-hook 'indent-defaults)
;(add-hook 'shell-mode-hook 'indent-defaults)
;(add-hook 'sh-mode-hook 'indent-defaults)

;(global-set-key (kbd "TAB") 'self-insert-command)

(setq inhibit-startup-message t)

(add-hook 'haskell-mode-hook 'haskell-indent-mode)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(defun set-mode-for-filename-patterns (mode filename-pattern-list)
  (mapcar
    (lambda (filename-pattern)
      (setq 
        auto-mode-alist 
        (cons (cons filename-pattern mode) auto-mode-alist)))
    filename-pattern-list))

(set-mode-for-filename-patterns 
  'ruby-mode
  '("\\.rb$"
    "\\.rsel$"
    "\\.rhtml$"
    "\\.erb$" 
    "\\.prawn$"
    "Rakefile$"
    "Gemfile$"))

(set-mode-for-filename-patterns
  'c++-mode
  '("\\.h"
    "\\.cpp"))

(blink-cursor-mode 0)

(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

(show-paren-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ahk-syntax-directory "~/.emacs.d/plugins/ahk-mode/")
 '(magit-use-overlays nil)
 '(tab-width 4)
 '(indent-tabs-mode t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq org-agenda-files '("~/org"))
(setq org-directory "~/org/")
(setq org-mobile-directory "~/Dropbox/mobileorg")
(setq org-mobile-inbox-for-pull "~/Dropbox/mobileorg/from-phone.org")

(add-hook 'org-mode-hook (lambda () (evil-leader/set-key 
				      "op" 'org-mobile-push
				      "ou" 'org-mobile-pull)))

(require 'auto-complete-clang-async)

(defun ac-cc-mode-setup ()
	(setq ac-clang-complete-executable "~/.emacs.d/clang-complete")
	(setq ac-sources '(ac-source-clang-async))
	(ac-clang-launch-completion-process)
)

(defun ac-common-setup ()
	()
)

(defun my-ac-config ()
	(add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
	(add-hook 'auto-complete-mode-hook 'ac-common-setup)
	(global-auto-complete-mode t)
)

(my-ac-config)
