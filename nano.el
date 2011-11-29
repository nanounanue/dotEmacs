;; Cargamos el tema "tango-dark"
(load-theme 'tango-dark)


;; Fuente
;; (set-face-font 'default "fixed")

;; (set-face-attribute 'default nil :font "-dec-terminal-medium-r-normal-*-*-140-*-*-c-*-iso8859-1")

(set-face-attribute 'default nil :family "Inconsolata" :height 100)




;; Railscast theme
;;(load-file "~/.emacs.d/nano/color-theme-railscasts.el")
;;(color-theme-railscasts)

;;; Rails

;; Cucumber mode
(add-to-list 'load-path "~/.emacs.d/nano/feature-mode")
(setq feature-default-language "es")
(setq feature-default-i18n-file "~/.emacs.d/nano/feature-mode/i18n.yml")
(require 'feature-mode)
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))

;;; Org - mode
(require 'org-latex)

;; Tomado de Emacs-fu
;; URL =>
;; http://emacs-fu.blogspot.com/2011/04/nice-looking-pdfs-with-org-mode-and.html

;; 'nano-org-article' para exportar documentos org a  LaTeX usando
;; XeTeX y otras letras bonitas; require, por supuesto, XeTeX
;; (ver org-latex-to-pdf-process)
(add-to-list 'org-export-latex-classes
             '("nano-org-article"
               "\\documentclass[11pt,letter]{article}
\\usepackage[T1]{fontenc}
\\usepackage{fontspec}
\\usepackage{graphicx} 
\\defaultfontfeatures{Mapping=tex-text}
\\setromanfont{Gentium}
\\setromanfont [BoldFont={Gentium Basic Bold},
                ItalicFont={Gentium Basic Italic}]{Gentium Basic}
\\setsansfont{Charis SIL}
\\setmonofont[Scale=0.8]{DejaVu Sans Mono}
\\usepackage{geometry}
\\geometry{a4paper, textwidth=6.5in, textheight=10in,
            marginparsep=7pt, marginparwidth=.6in}
\\pagestyle{empty}
\\title{}
      [NO-DEFAULT-PACKAGES]
      [NO-PACKAGES]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))



(setq org-latex-to-pdf-process 
      '("xelatex -interaction nonstopmode %f"
        "xelatex -interaction nonstopmode %f")) ;; for multiple passes

;; Configure Org-mode
  (setq org-export-latex-hyperref-format "\\ref{%s}")
  (setq org-entities-user '(("space" "\\ " nil " " " " " " " ")))
  (setq org-latex-to-pdf-process '("texi2dvi --pdf --clean --verbose --batch %f"))
  (require 'org-special-blocks)
  (defun org-export-latex-no-toc (depth)  
    (when depth
      (format "%% Org-mode is exporting headings to %s levels.\n"
              depth)))
  (setq org-export-latex-format-toc-function 'org-export-latex-no-toc)
  (setq org-export-pdf-remove-logfiles nil)

;; Add natbib link types
(require 'org-latex)
(org-add-link-type 
 "citep" 'ebib
 (lambda (path desc format)
   (cond
    ((eq format 'html)
     (format "(<cite>%s</cite>)" path))
    ((eq format 'latex)
     (if (or (not desc) (equal 0 (search "citep:" desc)))
         (format "\\citep{%s}" path)
       (format "\\citep[%s]{%s}" desc path))))))

(org-add-link-type 
 "citet" 'ebib
 (lambda (path desc format)
   (cond
    ((eq format 'html)
     (format "<cite>%s</cite>" path))
    ((eq format 'latex)
     (if (or (not desc) (equal 0 (search "citet:" desc)))
         (format "\\citet{%s}" path)
       (format "\\citet[%s]{%s}" desc path))))))

(org-add-link-type 
 "citet*" 'ebib
 (lambda (path desc format)
   (cond
    ((eq format 'latex)
     (if (or (not desc) (equal 0 (search "citet*:" desc)))
         (format "\\citet*{%s}" path)
       (format "\\citet*[%s]{%s}" desc path))))))

;; Add a new export class to use KOMA script
(add-to-list 'org-export-latex-classes
             '("koma-article"
               "\\documentclass{scrartcl}
             [NO-DEFAULT-PACKAGES]
             [EXTRA]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))







;; Org-babel

(setq org-ditaa-jar-path "~/software/java/ditaa0_9.jar")
(setq org-plantuml-jar-path "~/software/java/plantuml.jar")

;; stop C-c C-c within code blocks from querying
(setq org-confirm-babel-evaluate nil)

;; which languages do I want??
(org-babel-do-load-languages
 'org-babel-load-languages
  '((R . t)
    (sh . t)
    (ruby . t)
    (python . t)
    (clojure . t)
    (dot . t)
    (ditaa . t)
    (gnuplot . t)
    (latex . t)
    (octave . t)
    (emacs-lisp . t)
    ))




;; Habilitar ESS
(setq ess-swv-plug-into-AUCTeX-p t)

(load "~/.emacs.d/nano/ess-5.14/lisp/ess-site")


;; Ligar SCSS al CSS mode
(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))

;; Resize buffers
(global-set-key (kbd "<f5>") 'shrink-window-horizontally)
(global-set-key (kbd "<f6>") 'enlarge-window-horizontally)
(global-set-key (kbd "<f7>") 'shrink-window)
(global-set-key (kbd "<f8>") 'enlarge-window)


;; Goto-line
(global-set-key (kbd "C-c g") 'goto-line)

;; Ispell-word
(global-set-key (kbd "<f4>") 'ispell-word)

;; Coffee-script
(add-to-list 'load-path "~/.emacs.d/vendor/coffee-mode")
(require 'coffee-mode)

(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))


(defun coffee-custom ()
  "coffee-mode-hook"
  (set (make-local-variable 'tab-width) 2))



(defun coffee-custom ()
  "coffee-mode-hook"

  ;; CoffeeScript uses two spaces.
  (set (make-local-variable 'tab-width) 2)

  ;; If you don't have js2-mode
  (setq coffee-js-mode 'javascript-mode)

  ;; If you don't want your compiled files to be wrapped
  (setq coffee-args-compile '("-c" "--bare"))

  ;; *Messages* spam
  (setq coffee-debug-mode t)

  ;; Emacs key binding
  (define-key coffee-mode-map [(meta r)] 'coffee-compile-buffer)
  (define-key coffee-mode-map [(meta R)] 'coffee-compile-region)

  ;; Riding edge
  ;; (setq coffe-command "~/dev/coffee")

  
  ;; Compile '.coffee' files on every save
  (and (file-exists-p (buffer-file-name))
       (file-exists-p (coffee-compiled-file-name))
       (coffee-cos-mode t)))

(add-hook 'coffee-mode-hook 'coffee-custom)


;; Pig mode
(require 'pig-mode)
