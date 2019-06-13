
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
 '(ansi-color-names-vector
   ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#b2b2b2"])
 '(custom-safe-themes
   (quote
    ("aaeb61894d5d3c586d27cee61a3f54493c383733f8d900e05c6fbc8ef6d6bc93" "c53b6a09c7d997c3185cb1598de1d0ff15e1679f5445f9a6cb8b2bf4fc4e565a" "c8d19a09f9d2cb1d6aa6c57e1a86b2dab863cc77a3fc7225a4e60baba96726a1" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "436b185b423b78eb5d110dc23f4b95d78a1f002d156f226b7e6e5b1f6493dda0" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(dired-find-subdir nil)
 '(fci-rule-color "#dedede")
 '(line-spacing 0.2)
 '(pdf-view-midnight-colors (quote ("#b2b2b2" . "#292b2e")))
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
