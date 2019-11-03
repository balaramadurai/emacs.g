
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq load-prefer-newer t) ;; Let's do that early.

;;; Borg

(add-to-list 'load-path (expand-file-name "lib/borg" user-emacs-directory))
(require 'borg)
(borg-initialize)

(defvar required-drones nil)
(defun add-required-drone (drone others)
  (when drone
    (if (listp drone)
          (add-required-drone (car drone) (cdr drone))
          (add-to-list 'required-drones (symbol-name drone))))
  (when others
    (add-required-drone (car others) (cdr others)))
  required-drones)

(defmacro want-drone (drone &rest others)
  `(add-required-drone (quote ,drone) (quote ,others)))

(defalias 'want-drones 'want-drone)

(want-drone borg (epkg (closql))
            borg-nix-shell
            borg-queen)

;;; Auto compile

(want-drone auto-compile)
(auto-compile-on-load-mode)

;;; Load configuration

(unless noninteractive
  (require 'org)
  (org-babel-load-file (expand-file-name "dotemacs.org" user-emacs-directory)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#b2b2b2"])
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-enabled-themes (quote (dichromacy)))
 '(custom-safe-themes
   (quote
    ("2925ed246fb757da0e8784ecf03b9523bccd8b7996464e587b081037e0e98001" "aaeb61894d5d3c586d27cee61a3f54493c383733f8d900e05c6fbc8ef6d6bc93" "c53b6a09c7d997c3185cb1598de1d0ff15e1679f5445f9a6cb8b2bf4fc4e565a" "c8d19a09f9d2cb1d6aa6c57e1a86b2dab863cc77a3fc7225a4e60baba96726a1" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "436b185b423b78eb5d110dc23f4b95d78a1f002d156f226b7e6e5b1f6493dda0" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(fci-rule-color "#dedede")
 '(line-spacing 0.2)
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(org-babel-python-command "python3")
 '(org-time-stamp-custom-formats (quote ("%d %b %Y" . "<%m/%d/%y %a %H:%M>")))
 '(package-selected-packages (quote (org-fancy-priorities delight)))
 '(pdf-view-midnight-colors (quote ("#b2b2b2" . "#292b2e")))
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3")
 '(yequake-frames
   (quote
    (("org-capture"
      (buffer-fns yequake-org-capture)
      (width . 0.75)
      (height . 0.5)
      (alpha . 0.95)
      (frame-parameters
       (undecorated . t)
       (skip-taskbar . t)
       (sticky . t)))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
