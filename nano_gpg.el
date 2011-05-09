;; EasyPG (GPG for emacs)
(require 'epa)
(require 'epa-file)
(epa-file-enable)

; EPG support for GNUS
;;(setq gnus-treat-x-pgp-sig t
;;      mm-verify-option ‘always
;;      mm-decrypt-option ‘always)


(provide 'nano_gpg)
