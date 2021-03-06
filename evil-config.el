(setq evil-search-module 'evil-search
      evil-want-C-u-scroll t
      evil-want-C-w-in-emacs-state t)

(evil-mode t)

(define-key evil-insert-state-map "\C-c" 'evil-normal-state)
(define-key evil-visual-state-map "\C-c" 'evil-normal-state)

(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "e" 'find-file
  "b" 'switch-to-buffer
  "k" 'kill-buffer
  "w" 'save-buffer
  "gg" 'vc-next-action
  "gp" 'magit-push
  "gu" 'magit-pull
  "gs" 'magit-status
  "gr" 'magit-refresh
  "SPC" 'evil-visual-line
  "m" 'compile
  "ci" 'evilnc-comment-or-uncomment-lines
  "cl" 'evilnc-comment-or-uncomment-to-the-line
  "cc" 'evilnc-copy-and-comment-lines
  "cp" 'evilnc-comment-or-uncomment-paragraphs
  "cr" 'comment-or-uncomment-region
  "sp" 'ispell-buffer
  "i" 'whitespace-mode
  "f" 'auto-fill-mode
  "n" 'next-error
  "p" 'previous-error
)

(defun run-python-file ()
    (call-process (concat "python3" buffer-file-name)))

(add-hook 'python-mode-hook (lambda () (evil-leader/set-key 
				      "r" 'run-python-file)))

(define-key evil-motion-state-map "," 'evil-repeat-find-char-reverse)

; courtesy of Gordon Gustafson on StackOverflow
; originally posted 2014-03-15
; http://stackoverflow.com/questions/18102004/emacs-evil-mode-how-to-create-a-new-text-object-to-select-words-with-any-non-sp
 
(defmacro define-and-bind-text-object (key start-regex end-regex)
(let ((inner-name (make-symbol "inner-name"))
(outer-name (make-symbol "outer-name")))
`(progn
(evil-define-text-object ,inner-name (count &optional beg end type)
(evil-regexp-range count beg end type ,start-regex ,end-regex t))
(evil-define-text-object ,outer-name (count &optional beg end type)
(evil-regexp-range count beg end type ,start-regex ,end-regex nil))
(define-key evil-inner-text-objects-map ,key (quote ,inner-name))
(define-key evil-outer-text-objects-map ,key (quote ,outer-name)))))
 
;;; Useage:
 
; between dollars sign:
(define-and-bind-text-object "$" "\\$" "\\$")
