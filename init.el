
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
 '(package-selected-packages (quote (ob-ipython))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
