;;;
;;; Org Mode
;;;

(setq load-path (cons "~/software/org-mode/lisp" load-path))
(setq load-path (cons "~/software/org-mode/contrib/lisp" load-path))

;;; Basado en Org Mode - Organize Your Life In Plain Text!
;;; (http://doc.norang.ca/org-mode.html)


(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
(require 'org-install)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)




;; Make TAB the yas trigger key in the org-mode-hook and enable
;; flyspell mode and autofill 
(add-hook 'org-mode-hook
          (lambda ()
            ;; yasnippet
            (make-variable-buffer-local 'yas/trigger-key)
            (org-set-local 'yas/trigger-key [tab])
            (define-key yas/keymap [tab] 'yas/next-field-group)
            ;; flyspell mode for spell checking everywhere
            (flyspell-mode 1)
            ;; auto-fill mode on
            (auto-fill-mode 1)))


;;; Conecta org con gnus
(setq message-mode-hook
      (quote (orgstruct++-mode
              (lambda nil (setq fill-column 72) (flyspell-mode 1))
              turn-on-auto-fill
              bbdb-define-all-aliases)))

;; Agenda
(setq org-agenda-files (quote ("~/Documentos/orgs/notas.org"
                               "~/Documentos/orgs/c3.org"
                               "~/Documentos/orgs/articulos.org"
                               "~/Documentos/orgs/arquitecturaC3.org"
                               "~/Documentos/orgs/todo.org"
                               "~/Documentos/orgs/diario.org"
                               "~/Documentos/orgs/brazalete.org")))

;; Custom Key Bindings
(global-set-key (kbd "<f12>") 'org-agenda)
(global-set-key (kbd "<f5>") 'nano/org-todo)
(global-set-key (kbd "<S-f5>") 'nano/widen)
(global-set-key (kbd "<f7>") 'set-truncate-lines)
(global-set-key (kbd "<f8>") 'org-cycle-agenda-files)
(global-set-key (kbd "<f9> b") 'bbdb)
(global-set-key (kbd "<f9> c") 'calendar)
(global-set-key (kbd "<f9> f") 'boxquote-insert-file)
(global-set-key (kbd "<f9> g") 'gnus)
(global-set-key (kbd "<f9> h") 'nano/hide-other)

(defun nano/hide-other ()
  (interactive)
  (save-excursion
    (org-back-to-heading)
    (org-shifttab)
    (org-reveal)
    (org-cycle)))

(global-set-key (kbd "<f9> i") 'org-info)


(global-set-key (kbd "<f9> I") 'nano/clock-in)
(global-set-key (kbd "<f9> O") 'nano/clock-out)
(global-set-key (kbd "<f9> r") 'boxquote-region)
(global-set-key (kbd "<f9> s") 'nano/go-to-scratch)

(defun nano/go-to-scratch ()
  (interactive)
  (switch-to-buffer "*scratch*")
  (delete-other-windows))

(global-set-key (kbd "<f9> t") 'nano/insert-inactive-timestamp)
(global-set-key (kbd "<f9> u") 'nano/untabify)

(defun nano/untabify ()
  (interactive)
  (untabify (point-min) (point-max)))

(global-set-key (kbd "<f9> v") 'visible-mode)
(global-set-key (kbd "<f9> SPC") 'nano/clock-in-last-task)
(global-set-key (kbd "C-<f9>") 'previous-buffer) 
(global-set-key (kbd "C-x n r") 'narrow-to-region)
(global-set-key (kbd "C-<f10>") 'next-buffer)
(global-set-key (kbd "<f11>") 'org-clock-goto)
(global-set-key (kbd "C-<f11>") 'org-clock-in)
(global-set-key (kbd "C-s-<f12>") 'nano/save-then-publish)
(global-set-key (kbd "M-<f11>") 'org-resolve-clocks)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "M-<f9>") (lambda ()
                                 (interactive)
                                 (unless (buffer-modified-p)
                                   (kill-buffer (current-buffer)))
                                 (delete-frame)))

;; TODO Keywords
(setq org-todo-keywords (quote (
                                (sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!/!)")
                                (sequence "WAITING(w@/!)" "SOMEDAY(s!)" "|" "CANCELLED (c@/!)")
                                (sequence "QUOTE(q!)" "QUOTED(Q!)" "|" "APPROVED(A@)" "EXPIRED(E@)" "REJECTED(R@)")
                                (sequence "OPEN(O)"  "|" "CLOSED(C)" ))))

(setq org-todo-keyword-faces
      (quote (("TODO"      :foregroud "red"           :weight bold)
              ("NEXT"      :foreground "blue"         :weight bold)
              ("DONE"      :foreground "forest green" :weight bold)
              ("WAITING"   :foreground "yellow"       :weight bold)
              ("SOMEDAY"   :foreground "goldenrod"    :weight bold)
              ("CANCELLED" :foreground "orangered"    :weight bold)
              ("QUOTE"     :foreground "hotpink"      :weight bold)
              ("QUOTED"    :foreground "indieanred1"  :weight bold)
              ("APPROVED"  :foreground "forest green" :weight bold)
              ("EXPIRED"   :foreground "olivedrab1"   :weight bold)
              ("REJECTED"  :foreground "olivedrab"    :weight bold)
              ("OPEN"      :foreground "magenta"      :weight bold)
              ("CLOSED"    :foreground "forest green" :weight bold))))


;;; Fast todo selection allows changing from any task todo state to
;;; any other state directly by selecting the appropriate key from the
;;; fast todo selection key menu.  
(setq org-use-fast-todo-selection t)


;;; This setting allows changing todo states with S-left and S-right
;;; skipping all of the normal processing when entering or leaving a
;;; todo state.
(setq org-treat-S-cursor-todo-selection-as-state-change nil)


;;; A few triggers that automatically assign tags to tasks based on
;;; state changes.  
(setq org-todo-state-tags-triggers
      (quote (("CANCELLED"
               ("CANCELLED" . t))
              ("WAITING"
               ("WAITING" . t))
              ("SOMEDAY"
               ("WAITING" . t))
              (done
               ("WAITING"))
              ("TODO"
               ("WAITING")
               ("CANCELLED"))
              ("NEXT"
               ("WAITING"))
              ("DONE"
               ("WAITING")
               ("CANCELLED")))))

(defun nano/clock-in-to-next (kw)
  "Switch task from TODO to NEXT when clocking in.
Skips capture tasks and tasks with substasks."
  (if (and (string-equal kw "TODO")
           (not (and (boundp 'org-capture-mode) org-capture-mode)))
      (let ((subtree-end (save-excursion (org-end-of-subtree t)))
            (has-subtask nil))
        (save-excursion
         (forward-line 1)
         (while (and (not has-subtask)
                     (< (point) subtree-end)
                     (re-search-forward "^\*+ " subtree-end t))
           (when (member (org-get-todo-state) org-not-done-keywords)
             (setq has-subtask t))))
        (when (not has-subtask)
          "NEXT"))))

;;; When a new task needs to be added I categorize it into one of three things:
;;     * A phone call
;;     * A new task
;;     * A new note
;; and pick the appropriate capture task.

(setq org-default-notes-file "~/Documentos/orgs/notas.org")

(global-set-key (kbd "C-M-r") 'org-capture)

;; 3 capture templates for TODO tasks, Notes, and org-protocol (untested)
(setq org-capture-templates (quote (
                                    ("t" "todo" entry (file "~/Documentos/orgs/notas.org") "* TODO %? 
  %U
  %a" :clock-in t :clock-resume t)
                                    ("n" "note" entry (file "~/Documentos/orgs/notas.org") "* %?                                                                            :NOTE:
  %U
  %a
  :CLOCK:
  :END:" :clock-in t :clock-resume t)
                                    ("w" "org-protocol" entry (file "~/Documentos/orgs/notas.org") "* TODO Review %c
  %U" :immediate-finish t :clock-in t :clock-resume t))))



;; Remove empty CLOCK drawers on clock out
(defun nano/remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at "CLOCK" (point))))

(add-hook 'org-clock-out-hook 'nano/remove-empty-drawer-on-clock-out 'append)

;;; Notas Setup

;; To notas tasks in org you need to tell it where you want to notas things.

;; In my setup I let any file in org-agenda-files and the current file
;; contribute to the list of valid notas targets. I don't notas to
;; tasks more then 5 levels deep just to limit the number of displayed
;; targets. I also use ido mode to help find targets quickly. 

; Use IDO for target completion
(setq org-completion-use-ido t)

; Targets include this file and any file contributing to the agenda - up to 5 levels deep
(setq org-refile-targets (quote ((org-agenda-files :maxlevel . 5) (nil :maxlevel . 5))))

; Targets start with the file name - allows creating level 1 tasks
(setq org-refile-use-outline-path (quote file))

; Targets complete in steps so we start with filename, TAB shows the next level of targets etc
(setq org-outline-path-complete-in-steps t)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; Use IDO only for buffers
; set ido-mode to buffer and ido-everywhere to t via the customize interface
; '(ido-mode (quote both) nil (ido))
; '(ido-everywhere t)


(setq org-agenda-custom-commands
      (quote (("w" "Tasks waiting on something" tags "WAITING/!"
               ((org-use-tag-inheritance nil)
                (org-agenda-todo-ignore-scheduled nil)
                (org-agenda-todo-ignore-deadlines nil)
                (org-agenda-todo-ignore-with-date nil)
                (org-agenda-overriding-header "Waiting Tasks")))
              ("r" "Refile New Notes and Tasks" tags "LEVEL=1+REFILE"
               ((org-agenda-todo-ignore-with-date nil)
                (org-agenda-todo-ignore-deadlines nil)
                (org-agenda-todo-ignore-scheduled nil)
                (org-agenda-overriding-header "Tasks to Refile")))
              ("N" "Notes" tags "NOTE"
               ((org-agenda-overriding-header "Notes")))
              ("n" "Next" tags-todo "-WAITING-CANCELLED/!NEXT"
               ((org-agenda-overriding-header "Next Tasks")))
              ("p" "Projects" tags-todo "LEVEL=2-REFILE|LEVEL=1+REFILE/!-DONE-CANCELLED"
               ((org-agenda-skip-function 'nano/skip-non-projects)
                (org-agenda-overriding-header "Projects")))
              ("o" "Other (Non-Project) tasks" tags-todo "LEVEL=2-REFILE|LEVEL=1+REFILE/!-DONE-CANCELLED"
               ((org-agenda-skip-function 'nano/skip-projects)
                (org-agenda-overriding-header "Other Non-Project Tasks")))
              ("A" "Tasks to be Archived" tags "LEVEL=2-REFILE/DONE|CANCELLED"
               ((org-agenda-overriding-header "Tasks to Archive")))
              ("h" "Habits" tags "STYLE=\"habit\""
               ((org-agenda-todo-ignore-with-date nil)
                (org-agenda-todo-ignore-scheduled nil)
                (org-agenda-todo-ignore-deadlines nil)
                (org-agenda-overriding-header "Habits")))
              ("#" "Stuck Projects" tags-todo "LEVEL=2-REFILE|LEVEL=1+REFILE/!-DONE-CANCELLED"
               ((org-agenda-skip-function 'nano/skip-non-stuck-projects)
                (org-agenda-overriding-header "Stuck Projects")))
              ("c" "Select default clocking task" tags "LEVEL=2-REFILE"
               ((org-agenda-skip-function
                 '(org-agenda-skip-subtree-if 'notregexp "^\\*\\* Organization"))
                (org-agenda-overriding-header "Set default clocking task with C-u C-u I"))))))

(defun nano/weekday-p ()
  (let ((wday (nth 6 (decode-time))))
    (and (< wday 6) (> wday 0))))

(defun nano/working-p ()
  (let ((hour (nth 2 (decode-time))))
    (and (nano/weekday-p) (or (and (>= hour 8) (<= hour 11))
                            (and (>= 13) (<= hour 16))))))

(defun nano/network-p ()
  (= 0 (call-process "/bin/ping" nil nil nil
                     "-c1" "-q" "-t1" "norang.ca")))


(defun nano/org-auto-exclude-function (tag)
  (and (cond
        ((string= tag "@home")
         (nano/working-p))
        ((string= tag "@office")
         (not (nano/working-p)))
        ((or (string= tag "@errand") (string= tag "phone"))
         (let ((hour (nth 2 (decode-time))))
           (or (< hour 8) (> hour 21)))))
       (concat "-" tag)))

(setq org-agenda-auto-exclude-function 'nano/org-auto-exclude-function)


;;
;; Resume clocking tasks when emacs is restarted
(org-clock-persistence-insinuate)
;;
;; Yes it's long... but more is better ;)
(setq org-clock-history-length 28)
;; Resume clocking task on clock-in if the clock is open
(setq org-clock-in-resume t)
;; Change task state to NEXT when clocking in
(setq org-clock-in-switch-to-state (quote nano/clock-in-to-next))
;; Separate drawers for clocking and logs
(setq org-drawers (quote ("PROPERTIES" "LOGBOOK" "CLOCK")))
;; Save clock data in the CLOCK drawer and state changes and notes in
;; the LOGBOOK drawer 
(setq org-clock-into-drawer "CLOCK")
;; Sometimes I change tasks I'm clocking quickly - this removes
;; clocked tasks with 0:00 duration 
(setq org-clock-out-remove-zero-time-clocks t)
;; Clock out when moving task to a done state
(setq org-clock-out-when-done t)
;; Save the running clock and all clock history when exiting Emacs,
;; load it on startup 
(setq org-clock-persist (quote history))
;; Enable auto clock resolution for finding open clocks
(setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
;; Include current clocking task in clock reports
(setq org-clock-report-include-clocking-task t)

(setq nano/keep-clock-running nil)

(defun nano/clock-in ()
  (interactive)
  (setq nano/keep-clock-running t)
  (if (marker-buffer org-clock-default-task)
      (unless (org-clock-is-active)
        (nano/clock-in-default-task))
    (unless (marker-buffer org-clock-default-task)
      (org-agenda nil "c"))))

(defun nano/clock-out ()
  (interactive)
  (setq nano/keep-clock-running nil)
  (when (org-clock-is-active)
    (org-clock-out)))

(defun nano/clock-in-default-task ()
  (save-excursion
    (org-with-point-at org-clock-default-task
      (org-clock-in))))

(defun nano/clock-out-maybe ()
  (when (and nano/keep-clock-running (not org-clock-clocking-in) (marker-buffer org-clock-default-task)) 
    (nano/clock-in-default-task)))

(add-hook 'org-clock-out-hook 'nano/clock-out-maybe 'append)

(require 'org-id)
(defun nano/clock-in-task-by-id (id)
  "Clock in a task by id"
  (save-restriction
    (widen)
    (org-with-point-at (org-id-find id 'marker)
      (org-clock-in nil))))

(defun nano/clock-in-last-task ()
  "Clock in the interrupted task if there is one"
  (interactive)
  (let ((clock-in-to-task (if (org-clock-is-active)
                              (setq clock-in-to-task (cadr org-clock-history))
                            (setq clock-in-to-task (car org-clock-history)))))
    (org-with-point-at clock-in-to-task
      (org-clock-in nil))))

(setq org-time-stamp-rounding-minutes (quote (1 15)))

;; Sometimes I change tasks I'm clocking quickly - this removes
;; clocked tasks with 0:00 duration 
(setq org-clock-out-remove-zero-time-clocks t)

;; Agenda log mode items to display (clock time only by default)
(setq org-agenda-log-mode-items (quote (clock)))


;; Agenda clock report parameters (no links, 2 levels deep)
(setq org-agenda-clockreport-parameter-plist (quote (:link nil :maxlevel 2)))

; Set default column view headings: Task Effort Clock_Summary
(setq org-columns-default-format "%80ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM")

; global Effort estimate values
(setq org-global-properties (quote (("Effort_ALL" . "0:10 0:30 1:00 2:00 3:00 4:00 5:00 6:00 7:00 8:00"))))


; Tags with fast selection keys
(setq org-tag-alist (quote ((:startgroup)
                            ("@errand" . ?e)
                            ("@office" . ?o)
                            ("@home" . ?h)
                            ("@farm" . ?f)
                            (:endgroup)
                            ("PHONE" . ?P)
                            ("QUOTE" . ?q)
                            ("WAITING" . ?w)
                            ("FARM" . ?F)
                            ("HOME" . ?H)
                            ("ORG" . ?O)
                            ("NORANG" . ?N)
                            ("crypt" . ?c)
                            ("MARK" . ?M)
                            ("NOTE" . ?n)
                            ("CANCELLED" . ?C))))

; Allow setting single tags without the menu
(setq org-fast-tag-selection-single-key (quote expert))

; For tag searches ignore tasks with scheduled and deadline dates
(setq org-agenda-tags-todo-honor-ignore-options t)


; Set f9-p to prompt for who is calling and preload the capture template
(global-set-key (kbd "<f9> p") 'nano/phone-call)

;;
;; Phone capture template handling with BBDB lookup
;; modified from the original code by Gregory J. Grubbs
;;
(defvar gjg/capture-phone-record nil
  "Either BBDB record vector, or person's name as a string, or nil")

(defun nano/phone-call ()
  (interactive)
  (let* ((myname (completing-read "Who is calling? " (bbdb-hashtable) 'bbdb-completion-predicate 'confirm))
         (my-bbdb-name (if (> (length myname) 0) myname nil)))
    (setq gjg/capture-phone-record
          (if my-bbdb-name
              (first (or (bbdb-search (bbdb-records) my-bbdb-name nil nil)
                         (bbdb-search (bbdb-records) nil my-bbdb-name nil)))
            myname))
    (other-window 1)
    (let ((org-capture-templates '(("P" "Phone" entry (file "~/Documentos/orgs/notas.org") "* TODO Phone %(gjg/bbdb-name) - %(gjg/bbdb-company)               :PHONE:\n  %U\n  %?" :clock-in t :clock-resume t))))
      (org-capture))))

(defun gjg/bbdb-name ()
  "Return full name of saved bbdb record, or empty string - for use in Capture templates"
  (if (and gjg/capture-phone-record (vectorp gjg/capture-phone-record))
      (concat "[[bbdb:"
              (bbdb-record-name gjg/capture-phone-record) "]["
              (bbdb-record-name gjg/capture-phone-record) "]]")
    "NAME"))

(defun gjg/bbdb-company ()
  "Return company of saved bbdb record, or empty string - for use in Capture templates" 
  (if (and gjg/capture-phone-record (vectorp gjg/capture-phone-record))
      (or (bbdb-record-company gjg/capture-phone-record) "")
    "COMPANY"))



(setq org-agenda-ndays 1)


(defun nano/is-project-p ()
  "Any task with a todo keyword subtask"
  (let ((has-subtask)
        (subtree-end (save-excursion (org-end-of-subtree t))))
    (save-excursion
      (forward-line 1)
      (while (and (not has-subtask)
                  (< (point) subtree-end)
                  (re-search-forward "^\*+ " subtree-end t))
        (when (member (org-get-todo-state) org-todo-keywords-1)
          (setq has-subtask t))))
    has-subtask))

(defun nano/skip-non-stuck-projects ()
  "Skip trees that are not stuck projects"
  (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
         (has-next (save-excursion
                     (forward-line 1)
                     (and (< (point) subtree-end)
                          (re-search-forward "^\\*+ NEXT " subtree-end t)))))
    (if (and (nano/is-project-p) (not has-next))
        nil ; a stuck project, has subtasks but no next task
      subtree-end)))

(defun nano/skip-non-projects ()
  "Skip trees that are not projects"
  (let* ((subtree-end (save-excursion (org-end-of-subtree t))))
    (if (nano/is-project-p)
        nil
      subtree-end)))

(defun nano/skip-projects ()
  "Skip trees that are projects"
  (let* ((subtree-end (save-excursion (org-end-of-subtree t))))
    (if (nano/is-project-p)
        subtree-end
      nil)))


(setq org-archive-mark-done nil)


(setq org-ditaa-jar-path "~/java/ditaa0_6b.jar")

(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)

(setq org-babel-load-languages (quote ((emacs-lisp . t)
                                       (dot . t)
                                       (ditaa . t)
                                       (R . t)
                                       (python . t)
                                       (ruby . t)
                                       (gnuplot . t)
                                       (clojure . t)
                                       (sh . t))))

;;; Do not prompt to confirm evaluation
;;; This may be dangerous - make sure you understand the consequences
;;; of setting this -- see the docstring for details
(setq org-confirm-babel-evaluate nil)


;;; experimenting with docbook exports - not finished
(setq org-export-docbook-xsl-fo-proc-command "fop %s %s")
(setq org-export-docbook-xslt-proc-command "xsltproc --output %s /usr/share/xml/docbook/stylesheet/nwalsh/fo/docbook.xsl %s")
;
;;; Inline images in HTML instead of producting links to the image
(setq org-export-html-inline-images t)
;;; Do not use sub or superscripts - I currently don't need this
;;; functionality in my documents 
(setq org-export-with-sub-superscripts nil)
;;; Use org.css from the norang website for export document stylesheets
(setq org-export-html-style-extra "<link rel=\"stylesheet\" href=\"http://doc.norang.ca/org.css\" type=\"text/css\" />")
(setq org-export-html-style-include-default nil)
;;; Do not generate internal css formatting for HTML exports
(setq org-export-htmlize-output-type (quote css))
;;; Export with LaTeX fragments
(setq org-export-with-LaTeX-fragments t)

;;; List of projects
;;; norang - http://www.norang.ca/
;;; doc    - http://doc.norang.ca/
;;; org    - miscellaneous todo lists for publishing
(setq org-publish-project-alist

;;; http://www.norang.ca/  (norang website)
;;; norang-org are the org-files that generate the content
;;; norang-extra are images and css files that need to be included
;;; norang is the top-level project that gets published
      (quote (("norang-org"
               :base-directory "~/git/www.norang.ca"
               :publishing-directory "/ssh:www-data@www:~/www.norang.ca/htdocs"
               :recursive t
               :section_numbers nil
               :table-of-contents nil
               :base-extension "org"
               :publishing-function org-publish-org-to-html
               :style-include-default nil
               :section-numbers nil
               :table-of-contents nil
               :style-include-default nil
               :style "<link rel=\"stylesheet\" href=\"norang.css\" type=\"text/css\">"
               :author-info nil
               :creator-info nil)
              ("norang-extra"
               :base-directory "~/git/www.norang.ca/"
               :publishing-directory "/ssh:www-data@www:~/www.norang.ca/htdocs"
               :base-extension "css\\|pdf\\|png\\|jpg\\|gif"
               :publishing-function org-publish-attachment
               :recursive t
               :author nil)
              ("norang"
               :components ("norang-org" "norang-extra"))
;
;;; http://doc.norang.ca/  (norang website)
;;; doc-org are the org-files that generate the content
;;; doc-extra are images and css files that need to be included
;;; doc is the top-level project that gets published
              ("doc-org"
               :base-directory "~/git/doc.norang.ca/"
               :publishing-directory "/ssh:www-data@www:~/doc.norang.ca/htdocs"
               :recursive t
               :section_numbers nil
               :table-of-contents nil
               :base-extension "org"
               :publishing-function (org-publish-org-to-html org-publish-org-to-org)
               :plain-source t
               :htmlized-source t
               :style-include-default nil
               :style "<link rel=\"stylesheet\" href=\"/org.css\" type=\"text/css\">"
               :author-info nil
               :creator-info nil)
              ("doc-extra"
               :base-directory "~/git/doc.norang.ca/"
               :publishing-directory "/ssh:www-data@www:~/doc.norang.ca/htdocs"
               :base-extension "css\\|pdf\\|png\\|jpg\\|gif"
               :publishing-function org-publish-attachment
               :recursive t
               :author nil)
              ("doc"
               :components ("doc-org" "doc-extra"))

;;; Miscellaneous pages for other websites
;;; org are the org-files that generate the content
              ("org"
               :base-directory "~/git/org/"
               :publishing-directory "/ssh:www-data@www:~/org"
               :recursive t
               :section_numbers nil
               :table-of-contents nil
               :base-extension "org"
               :publishing-function org-publish-org-to-html
               :style-include-default nil
               :style "<link rel=\"stylesheet\" href=\"/org.css\" type=\"text/css\">"
               :author-info nil
               :creator-info nil))))

;;; I'm lazy and don't want to remember the name of the project to
;;; publish when I modify 
;;; a file that is part of a project.  So this function saves the
;;; file, and publishes 
;;; the project that includes this file
;;; 
;;; It's bound to C-S-F12 so I just edit and hit C-S-F12 when I'm done
;;; and move on to the next thing 
(defun nano/save-then-publish ()
  (interactive)
  (save-buffer)
  (org-save-all-org-buffers)
  (org-publish-current-project))

(global-set-key (kbd "C-s-<f12>") 'nano/save-then-publish)


;;; Reminders

;;; Erase all reminders and rebuilt reminders for today from the agenda
(defun nano/org-agenda-to-appt ()
  (interactive)
  (setq appt-time-msg-list nil)
  (org-agenda-to-appt))

;;; Rebuild the reminders everytime the agenda is displayed
(add-hook 'org-finalize-agenda-hook 'nano/org-agenda-to-appt)

;;; This is at the end of my .emacs - so appointments are set up when
;;; Emacs starts 
(nano/org-agenda-to-appt)

;;; Activate appointments so we get notifications
(appt-activate t)

;;; If we leave Emacs running overnight - reset the appointments one
;;; minute after midnight 
(run-at-time "24:01" nil 'nano/org-agenda-to-appt)


(global-set-key (kbd "<f5>") 'nano/org-todo)

(defun nano/org-todo ()
  (interactive)
  (org-narrow-to-subtree)
  (org-show-todo-tree nil))

(global-set-key (kbd "<S-f5>") 'nano/widen)

(defun nano/widen ()
  (interactive)
  (widen)
  (org-reveal))


;; Always hilight the current agenda line
(add-hook 'org-agenda-mode-hook '(lambda () (hl-line-mode 1)))


;; Keep tasks with dates off the global todo lists
(setq org-agenda-todo-ignore-with-date nil)

;; Allow deadlines which are due soon to appear on the global todo lists
(setq org-agenda-todo-ignore-deadlines (quote far))

;; Keep tasks scheduled in the future off the global todo lists
(setq org-agenda-todo-ignore-scheduled (quote future))

;; Remove completed deadline tasks from the agenda view
(setq org-agenda-skip-deadline-if-done t)

;; Remove completed scheduled tasks from the agenda view
(setq org-agenda-skip-scheduled-if-done t)

;; Remove completed items from search results
(setq org-agenda-skip-timestamp-if-done t)


(setq org-agenda-include-diary nil)
(setq org-agenda-diary-file "~/Documentos/orgs/diary.org")


;; Include agenda archive files when searching for things
(setq org-agenda-text-search-extra-files (quote (agenda-archives)))

;; Show all future entries for repeating tasks
(setq org-agenda-repeating-timestamp-show-all t)

;; Show all agenda dates - even if they are empty
(setq org-agenda-show-all-dates t)

;; Sorting order for tasks on the agenda
(setq org-agenda-sorting-strategy
      (quote ((agenda habit-down time-up user-defined-up priority-down effort-up category-keep)
              (todo priority-down)
              (tags priority-down))))

;; Start the weekly agenda today
(setq org-agenda-start-on-weekday nil)

;; Disable display of the time grid
(setq org-agenda-time-grid
      (quote (nil "----------------"
                  (800 1000 1200 1400 1600 1800 2000))))

;; Display tags farther right
(setq org-agenda-tags-column -102)

;;
;; Agenda sorting functions
;;
(setq org-agenda-cmp-user-defined 'nano/agenda-sort)

(defun nano/agenda-sort (a b)
  "Sorting strategy for agenda items.
Late deadlines first, then scheduled, then non-late deadlines"
  (let (result num-a num-b)
    (cond
     ; time specific items are already sorted first by org-agenda-sorting-strategy

     ; non-deadline and non-scheduled items next
     ((nano/agenda-sort-test 'nano/is-not-scheduled-or-deadline a b))

     ; late deadlines next
     ((nano/agenda-sort-test-num 'nano/is-late-deadline '< a b))

     ; deadlines for today next
     ((nano/agenda-sort-test 'nano/is-due-deadline a b))

     ; late scheduled items next
     ((nano/agenda-sort-test-num 'nano/is-scheduled-late '> a b))

     ; scheduled items for today next
     ((nano/agenda-sort-test 'nano/is-scheduled-today a b))

     ; pending deadlines last
     ((nano/agenda-sort-test-num 'nano/is-pending-deadline '< a b))

     ; finally default to unsorted
     (t (setq result nil)))
    result))

(defmacro nano/agenda-sort-test (fn a b)
  "Test for agenda sort"
  `(cond
    ; if both match leave them unsorted
    ((and (apply ,fn (list ,a))
          (apply ,fn (list ,b)))
     (setq result nil))
    ; if a matches put a first
    ((apply ,fn (list ,a))
     ; if b also matches leave unsorted
     (if (apply ,fn (list ,b))
         (setq result nil)
       (setq result -1)))
    ; otherwise if b matches put b first
    ((apply ,fn (list ,b))
     (setq result 1))
    ; if none match leave them unsorted
    (t nil)))

(defmacro nano/agenda-sort-test-num (fn compfn a b)
  `(cond
    ((apply ,fn (list ,a))
     (setq num-a (string-to-number (match-string 1 ,a)))
     (if (apply ,fn (list ,b))
         (progn
           (setq num-b (string-to-number (match-string 1 ,b)))
           (setq result (if (apply ,compfn (list num-a num-b))
                            -1
                          1)))
       (setq result -1)))
    ((apply ,fn (list ,b))
     (setq result 1))
    (t nil)))

(defun nano/is-not-scheduled-or-deadline (date-str)
  (and (not (nano/is-deadline date-str))
       (not (nano/is-scheduled date-str))))

(defun nano/is-due-deadline (date-str)
  (string-match "Deadline:" date-str))

(defun nano/is-late-deadline (date-str)
  (string-match "In *\\(-.*\\)d\.:" date-str))

(defun nano/is-pending-deadline (date-str)
  (string-match "In \\([^-]*\\)d\.:" date-str))

(defun nano/is-deadline (date-str)
  (or (nano/is-due-deadline date-str)
      (nano/is-late-deadline date-str)
      (nano/is-pending-deadline date-str)))

(defun nano/is-scheduled (date-str)
  (or (nano/is-scheduled-today date-str)
      (nano/is-scheduled-late date-str)))

(defun nano/is-scheduled-today (date-str)
  (string-match "Scheduled:" date-str))

(defun nano/is-scheduled-late (date-str)
  (string-match "Sched\.\\(.*\\)x:" date-str))


(load "~/software/org-mode/contrib/lisp/org-checklist")


(setq org-enforce-todo-dependencies t)

(setq org-hide-leading-stars nil)

(setq org-odd-levels-only nil)

(setq org-cycle-separator-lines 0)

(setq org-blank-before-new-entry (quote ((heading)
                                         (plain-list-item))))

(setq org-insert-heading-respect-content t)

(setq org-reverse-note-order nil)


(setq org-show-following-heading t)
(setq org-show-hierarchy-above t)
(setq org-show-siblings nil)

(setq org-special-ctrl-a/e t)
(setq org-special-ctrl-k t)
(setq org-yank-adjusted-subtrees t)

(setq org-id-method (quote uuidgen))

(setq org-deadline-warning-days 30)

(setq org-table-export-default-format "orgtbl-to-csv")

;; (setq org-link-frame-setup ( (vm . vm-visit-folder)
;;                             (gnus . org-gnus-no-new-news)
;;                             (file . find-file-other-window)))

(setq org-log-done (quote time))
(setq org-log-into-drawer t)

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "WAITING(w@/!)" "SOMEDAY(s!)" "|" "DONE(d!/!)" "CANCELLED(c@/!)")
              (sequence "QUOTE(Q!)" "QUOTED(D!)" "|" "APPROVED(A@)" "EXPIRED(E@)" "REJECTED(R@)")
              (sequence "OPEN(O)" "|" "CLOSED(C)"))))

(setq org-clock-sound "/usr/local/lib/alert1.wav")

; Enable habit tracking (and a bunch of other modules)
(setq org-modules (quote (org-bbdb org-bibtex org-crypt org-gnus org-id org-info org-jsinfo org-habit org-inlinetask org-irc org-mew org-mhe org-protocol org-rmail org-vm org-wl org-w3m)))
; global STYLE property values for completion
(setq org-global-properties (quote (("STYLE_ALL" . "habit"))))
; position the habit graph on the agenda to the right of the default
(setq org-habit-graph-column 50)

(run-at-time "06:00" 86400 '(lambda () (setq org-habit-show-habits t)))

(setq global-auto-revert-mode t)


(require 'org-crypt)
; Encrypt all entries before saving
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
; GPG key to use for encryption
(setq org-crypt-key "F0B66B40")

(setq org-use-speed-commands t)
(setq org-speed-commands-user (quote (("0" . delete-window)
                                      ("1" . delete-other-windows)
                                      ("2" . split-window-vertically)
                                      ("3" . split-window-horizontally)
                                      ("h" . hide-other)
                                      ("k" . org-kill-note-or-show-branches)
                                      ("r" . org-reveal)
                                      ("s" . org-save-all-org-buffers)
                                      ("z" . org-add-note))))

(require 'org-protocol)

(setq require-final-newline t)

(defun nano/insert-inactive-timestamp ()
  (interactive)
  (org-insert-time-stamp nil t t nil nil nil))

(global-set-key (kbd "<f9> t") 'nano/insert-inactive-timestamp)

(setq org-return-follows-link t)

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(org-mode-line-clock ((t (:background "grey75" :foreground "red" :box (:line-width -1 :style released-button)))) t)) 


(defun nano/prepare-meeting-notes ()
  "Prepare meeting notes for email
   Take selected region and convert tabs to spaces, mark TODOs with leading >>>, and copy to kill ring for pasting"
  (interactive)
  (let (prefix)
    (save-excursion
      (save-restriction
        (narrow-to-region (region-beginning) (region-end))
        (untabify (point-min) (point-max))
        (goto-char (point-min))
        (while (re-search-forward "^\\( *-\\\) \\(TODO\\|DONE\\): " (point-max) t)
          (replace-match (concat (make-string (length (match-string 1)) ?>) " " (match-string 2) ": ")))
        (goto-char (point-min))
        (kill-ring-save (point-min) (point-max))))))

(setq org-remove-highlights-with-change nil)


(add-to-list 'Info-default-directory-list "~/git/org-mode/doc")

(setq org-read-date-prefer-future nil)

(setq org-list-demote-modify-bullet (quote (("+" . "-")
                                            ("*" . "-")
                                            ("1." . "-")
                                            ("1)" . "-"))))

(run-at-time "00:59" 3600 'org-save-all-org-buffers)


(provide 'nano_org)



