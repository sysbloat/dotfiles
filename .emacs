; My emacs config file
; Borrowing some settings from Casey's (Handmade Hero) binds
; Changing them for unix+windows use
;
; - Matias Lago (sys_bloat)

; Stop Emacs from losing undo info by setting high limiters for buffers
(setq undo-limit 2000000)
(setq undo-strong-limit 40000000)

; Determine running OS
(setq matias-unix (featurep 'x))
(setq matias-win (not (or matias-unix)))

; Create log files
; (should depend on current directory)
; @TODO: implement this

; Toggle highlighting in all buffers, make it blue-colored
;(set-face-background 'hl-line "midnight blue") -> "invalid face hl-line"?)

; Disable scrollbar
(scroll-bar-mode -1)

; Disallow shift motions to set mark
(setq shift-select-mode nil)

; Disable local variables
(setq enable-local-variables nil)

; Backup font
(setq matias-font "outline-DejaVu Sans Mono")

; Set windows-specific behavior
(when matias-win
  (setq matias-font "outline-Palatino Linotype")
  )

; Set unix-specific behavior
(when matias-unix
  )

; Turn off toolbar
(tool-bar-mode 0)


; Loads some variable "view" -> what does it do?
(load-library "view")

; Require cc-mode (working with c/++, obj-c, etc. files) -> code indentation, etc
(require 'cc-mode)

; Require IDO mode - autocomplete stuff? (needs testing)
; Problem -> "forces" file completion and stuff - not good
(require 'ido)
(ido-mode t)


; Sets up 2 initial windows, split horizontally
(defun matias-ediff-setup-windows (buffer-A buffer-B buffer-C control-buffer)
  "Sets up some basic windows/buffer thing"
  (ediff-setup-windows-plain buffer-A buffer-B buffer-C control-buffer)
  )

(setq ediff-window-setup-function 'matias-ediff-setup-windows)
(setq ediff-split-window-function 'split-window-horizontally)

; Startup windowing
(setq next-line-add-newlines nil)
(setq-default truncate-lines t)
(setq truncate-partial-width-windows nil)
(split-window-horizontally)

; Cosmetic stuff (color, look, etc)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(auto-save-interval 0)
 '(auto-save-list-file-prefix nil)
 '(auto-save-timeout 0)
 '(auto-show-mode t t)
 '(delete-auto-save-files nil)
 '(delete-old-versions (quote other))
 '(imenu-auto-rescan t)
 '(imenu-auto-rescan-maxout 500000)
 '(kept-new-versions 5)
 '(kept-old-versions 5)
 '(make-backup-file-name-function (quote ignore))
 '(make-backup-files nil)
 '(mouse-wheel-follow-mouse nil)
 '(mouse-wheel-progressive-speed nil)
 '(mouse-wheel-scroll-amount (quote (15)))
 '(version-control nil))

(define-key global-map [C-tab] 'indent-region)


(add-to-list 'default-frame-alist '(font . "Liberation Mono-11.5"))
(add-to-list 'default-frame-alist `(fullscreen . maximized)) ; Fullscreen
(set-face-attribute 'default t :font "Liberation Mono-11.5")
(set-face-attribute 'font-lock-builtin-face nil :foreground "#DAB98F")
(set-face-attribute 'font-lock-comment-face nil :foreground "gray50")
(set-face-attribute 'font-lock-constant-face nil :foreground "olive drab")
(set-face-attribute 'font-lock-doc-face nil :foreground "gray50")
(set-face-attribute 'font-lock-function-name-face nil :foreground "burlywood3")
(set-face-attribute 'font-lock-keyword-face nil :foreground "DarkGoldenrod3")
(set-face-attribute 'font-lock-string-face nil :foreground "olive drab")
(set-face-attribute 'font-lock-type-face nil :foreground "burlywood3")
(set-face-attribute 'font-lock-variable-name-face nil :foreground "burlywood3")

(defun post-load-stuff ()
  (interactive)
  (menu-bar-mode -1) ; Disable menu bar
  (set-foreground-color "burlywood3")
  (set-background-color "#161616")
  (set-cursor-color "#40FF40")
)
(add-hook 'window-setup-hook 'post-load-stuff t)


; Red TODO's && Dark Green Note's
(setq fixme-modes '(c++-mode c-mode emacs-lisp-mode))
(make-face 'font-lock-fixme-face)
(make-face 'font-lock-note-face)
(mapc (lambda (mode)
	(font-lock-add-keywords
	 mode
	 '(("\\<\\(TODO\\)" 1 'font-lock-fixme-face t)
	   ("\\<\\(NOTE\\)" 1 'font-lock-note-face t))))
      fixme-modes)
(modify-face 'font-lock-fixme-face "Red" nil nil t nil t nil nil)
(modify-face 'font-lock-note-face "Dark Green" nil nil t nil t nil nil)


; Accepted file extensions and their appropriate modes
(setq auto-mode-alist
      (append
       '(("\\.cpp$"    . c++-mode)
         ("\\.hin$"    . c++-mode)
         ("\\.cin$"    . c++-mode)
         ("\\.inl$"    . c++-mode)
         ("\\.rdc$"    . c++-mode)
         ("\\.h$"    . c++-mode)
         ("\\.c$"   . c++-mode)
         ("\\.cc$"   . c++-mode)
         ("\\.c8$"   . c++-mode)
         ("\\.txt$" . indented-text-mode)
         ("\\.emacs$" . emacs-lisp-mode)
         ("\\.gen$" . gen-mode)
         ("\\.ms$" . fundamental-mode)
         ("\\.m$" . objc-mode)
         ("\\.mm$" . objc-mode)
         ) auto-mode-alist))

; C/++ indentation style
(defconst matias-c-style
  '((c-electric-pound-behavior . nil)
    (c-tab-always-indent . t)
    (c-comment-only-line-offset . 0)
    (c-hanging-braces-alist . ((class-open)
			       (class-close)
			       (defun-open)
			       (defun-close)
			       (inline-open)
			       (inline-close)
			       (brace-list-open)
			       (brace-list-close)
			       (brace-list-intro)
			       (brace-list-entry)
			       (block-open)
			       (block-close)
			       (substatement-open)
			       (substatement-case-open)
			       (class-open)))
    (c-hanging-colons-alist . ((inher-intro)
			       (case-label)
			       (label)
			       (access-label)
			       (access-key)
			       (member-init-intro)))
    (c-cleanup-list . (scope-operator
		       list-close-comma
		       defun-close-semi))
    (c-offsets-alist . ((arglist-close . c-lineup-arglist)
			(label . -4)
			(access-label -4)
			(substatement-open . 0)
			(substatement-case-intro . 4)
			(case-label . 4)
			(block-open . 0)
			(inline-open . 0)
			(topmost-intro-cont . 0)
			(knr-argdecl-intro . -4)
			(brace-list-open . 0)
			(brace-list-intro . 4)))
    (c-echo-syntactic-information-p . t))
  "Matias' C/++ Style")





























































































