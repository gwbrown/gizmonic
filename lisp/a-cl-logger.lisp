;; This file is some experimentation with the a-cl-logger package.
;; It is essentially repl notes, not intended to do anything on
;; its own.


(ql:quickload :a-cl-logger)

(rename-package :a-cl-logger :a-cl-logger '(log))

(log:define-logger jlog ()
  :appenders (make-instance
              'log:stderr-log-appender
              :formatter 'log:json-formatter))

(jlog.info "test")

(jlog.info :foo 5 :bar 6)

(log:when-log-message-generated ((log:push-into-message :a 1 :b 2))
  (jlog.debug "This message will have a=1 and b=2 in its data"))

(defun add-with-log (x y)
  (log:when-log-message-generated ((log:push-into-message :x x :y y))
    (let ((result (+ x y)))
      (jlog.info :result result)
      result)))


(log:when-log-message-generated ((log:push-into-message :a 1 :b 2))
  (add-with-log 4 5))


