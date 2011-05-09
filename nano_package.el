(add-to-list 'load-path "~/.emacs.d/vendor/el-get")
(require 'el-get)

(setq el-get-sources
      '((:name ruby-mode 
               :type elpa
               :load "ruby-mode.el")
        (:name inf-ruby  :type elpa)
        (:name ruby-compilation :type elpa)
        (:name css-mode :type elpa)
        (:name rinari
               :type git
               :url "git://github.com/eschulte/rinari.git"
               :load "rinari.el")
        (:name rvm
               :type git
               :url "http://github.com/djwhitt/rvm.el.git"
               :load "rvm.el"
               :compile ("rvm.el")
               :after (lambda() (rvm-use-default)))
        (:name rhtml
               :type git
               :url "https://github.com/eschulte/rhtml.git"
               :features rhtml-mode)
        (:name yaml-mode 
               :type git
               :url "http://github.com/yoshiki/yaml-mode.git"
               :features yaml-mode)))
(el-get 'sync)






(provide 'nano_package)
