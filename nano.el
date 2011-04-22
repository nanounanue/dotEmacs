;; Cargamos el tema "tango-dark"
(load-theme 'tango-dark)

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

;; 'nano-org-article' para expostar documentos org a  LaTeX usando
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
