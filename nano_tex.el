
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; AUCTeX
;; ./configure --with-lispdir=/home/nano/software/site-lisp 
;; make
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(load "auctex.el" nil t t)
;(load "preview-latex.el" nil t t)

;; Conectamos reftex con AUCTeX
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;; Conectamos AUCTeX con reftex
(setq reftex-plug-into-AUCTeX t)
;; Todos los .tex serán AUCTeX
(setq TeX-default-mode 'LaTeX-mode)
;; Activar siempre el modo
(setq TeX-force-default-mode t)
;; Salvar automáticamente los archivos .tex
(setq TeX-auto-save t)
;; Parsea los archivos TeX
(setq TeX-parse-self t)
;; Le indica a AuCTeX que se pueden utilizar multiarchivos
(setq-default TeX-master nil)
;; Auto-fill para tex
(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)
(add-hook 'LaTeX-mode-hook 'turn-on-flyspell)


(setq TeX-source-correlate-method (quote source-specials))
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
;;(setq LaTeX-command "latex --src-specials")



;; (setq TeX-source-correlate-method 'synctex)
;;  (add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
;; '(LaTeX-command "latex -synctex=1")

;; '(TeX-output-view-style '(("^pdf$" "." "evince %s.pdf")))



;;(setq TeX-source-specials-mode t)

;; Flyspell, usa el diccionario según la babel
;; (add-to-list 'load-path "~/.emacs.d/vendor/")
;; (autoload 'flyspell-babel-setup "flyspell-babel")
;; (add-hook 'latex-mode-hook 'flyspell-babel-setup)

;; Usa specials para compilar, esto ayudará a que cuando se haga clic en
;; el Xdvi se vaya a esa línea en GNU/Emacs
;; Manual AuTeX:
;; http://www.gnu.org/software/auctex/manual/auctex.html#I_002fO-Correlation
;;(setq TeX-source-correlate-mode t)
;; (setq TeX-source-correlate-start-server t)
;; Es necesario agregar esto al .Xdefaults:
;; xdvi.editor:emacsclient --no-wait +%l %f
;; y luego ejecutar:
;; xrdb -merge ~/.Xdefaults;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Whizzytex
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (autoload 'whizzytex-mode
;;   "whizzytex"
;;   "WhizzyTeX, a minor-mode WYSIWIG environment for LaTeX" t)

(provide 'nano_tex)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
