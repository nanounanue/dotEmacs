(add-to-list 'load-path "~/.emacs.d/vendor/bbdb/lisp")

'(require 'bbdb)
'(bbdb-initialize 'gnus 'message 'w3)

(setq bbdb-send-mail-style 'gnus)

'(add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)
'(bbdb-insinuate-message)
'(bbdb-insinuate-w3)

; Autocompletar
(setq bbdb-complete-name-full-completion t)
(setq bbdb-completion-type 'primary-or-name)
(setq bbdb-complete-name-allow-cycling t)

(setq
bbdb-offer-save 1
bbdb-use-pop-up t
bbdb-electric-p t
bbdb-popup-target-lines  1
)


; Stop showing when updates occur
(setq bbdb-message-pop-up nil)
 
; Stop echoing messages
(setq bbdb-silent t)
 
; Don't show completions in a new buffer
(setq bbdb-completion-display-record nil)
 
; Be quiet if names mismatch
(setq bbdb-accept-name-mismatch t)
 
; Don't ask me if I want to save the data base (automatically yes)
(setq bbdb-check-auto-save-file nil)
 
; Prevent bbdb from creating a new entry when reading mail/news
(setq bbdb-add-mails nil)
 
; Make bbdb-complete-mail cycle when several addresses
(setq bbdb-complete-mail-allow-cycling t)
 
 ; Insert name + email
(setq bbdb-mail-allow-redundancy t)




(provide 'nano_bbdb)


