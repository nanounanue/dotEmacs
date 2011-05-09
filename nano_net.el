;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Autor: nano AT dialetheia.net
;; Configuración con cosas relacionadas a la red: Twitter, Jabber, etc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;
;;; Twittering mode
;;;
;;; git clone git://github.com/hayamiz/twittering-mode.git
;;;
(add-to-list 'load-path "~/.emacs.d/vendor/twittering-mode")
(require 'twittering-mode)
(setq twittering-icon-mode t)
; Update your timeline each 300 seconds (5 minutes) 
(setq twittering-timer-interval 300)     
; Keeps the echo area from showing all the http processes
(setq twittering-url-show-status nil)       


;;;
;;; Jabber
;;;
;;; git clone
;;; git://emacs-jabber.git.sourceforge.net/gitroot/emacs-jabber/emacs-jabber 

;;;
(add-to-list 'load-path "~/.emacs.d/vendor/emacs-jabber")
(load "jabber-autoloads")


(setq jabber-account-list
      '(
        ("adolfo.unanue@chat.facebook.com"
         (:network-server . "chat.facebook.com")
         (:connection-type . network)
         )
        ("adolfoaz@gmail.com"
         (:connection-type . ssl)
         (:network-server . "talk.google.com")
         )
        ))


;; Colorea los URLs
(add-hook 'jabber-chat-mode-hook 'goto-address)

(provide 'nano_net)
