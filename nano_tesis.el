;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Archivo para cargar por default el bibtex de la tesis
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq reftex-cite-format 'natbib
      reftex-default-bibliography
      '("~/docs/tesis/bibliografia/tesis.bib")
      reftex-extra-bindings t
      reftex-plug-into-AUCTeX t
      reftex-sort-bibtex-matches 'year
      reftex-toc-mode-hook nil)


(provide 'nano_tesis)
