;; Automáticamente detecta los cambios en los búferes hechos por
;; aplicaciones externas
(global-auto-revert-mode t)



;; ReFTeX y BibLaTeX
(setq reftex-cite-format
      '((?\C-m . "\\cite[]{%l}")
        (?f . "\\footcite[][]{%l}")
        (?t . "\\textcite[]{%l}")
        (?p . "\\parencite[]{%l}")
        (?o . "\\citepr[]{%l}")
        (?n . "\\nocite{%l}")))
(setq reftex-cite-prompt-optional-args t)


;;
;; yasnippet
;;
(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet-0.6.1c")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet-0.6.1c/snippets")


;;
;; anything
;; 
(add-to-list 'load-path "~/.emacs.d/vendor/anything-config")
(require 'anything-config)
(require 'anything-match-plugin)



;; Crea un booklet (panfleto) a partir de un PDF!
;; (Increíble!)
;; Obtenido de
;; http://www.mostlymaths.net/2008/09/latex-booklets.html

(defun Booklet (NumPag)
  (interactive "sNumPag:")
  (let ((bookletprev (buffer-file-name (current-buffer))))
    (set-buffer (find-file "/home/nano/tmp/Booklets.tex"))
    (erase-buffer)
    (insert (concat "\\documentclass[a4paper]{article}
\\usepackage[pdftex]{color,graphicx,epsfig}
\\usepackage[final]{pdfpages}
\\begin{document}
\\includepdf[pages=-,nup=1x2,landscape,signature=
"
                    (number-to-string
                     (* (/ (+ 1 (string-to-number NumPag)) 4) 4))
                    "]{"
                    (substring bookletprev 0 (- (length bookletprev) 4))
                    ".pdf}
\\end{document}
")))
  (tex-pdf-mode)
  (save-buffer)
                                        ;(tex-run-command "LaTeX")
  )


;; Gnus desde Git
(setq load-path (cons (expand-file-name "~/.emacs.d/vendor/ngnus/lisp") load-path)) 
(require 'gnus-load)



;; Octave mode
(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))

;; Habilitar abreviaciones, auto-fill y font-lock
(add-hook 'octave-mode-hook
          (lambda ()
            (abbrev-mode 1)
            (auto-fill-mode 1)
            (if (eq window-system 'x)
                (fon (setq auto-mode-alist
                           font-lock-mode 1)))))



;; Ediff

;; Divide la ventana horizontal/verticalmente dependiendo del ancho de
;; la pantalla. Tomado desde: http://www.emacswiki.org/emacs/EdiffMode
(setq ediff-split-window-function (lambda (&optional arg)
                                    (if (> (frame-width) 150)
                                        (split-window-horizontally arg)
                                      (split-window-vertically arg))))




;; Cucumber
;; https://github.com/michaelklishin/cucumber.el
(add-to-list 'load-path "~/.emacs.d/vendor/cucumber.el/")
(require 'feature-mode)
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))



;;
;; When running in a windowed mode the mouse pointer shouldn't intefere
;; with the cursor.
;;
(if window-system
    (mouse-avoidance-mode 'cat-and-mouse))

(provide 'nano_varios)


