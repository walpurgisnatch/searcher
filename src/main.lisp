(defpackage searcher
  (:use :cl))

(in-package :searcher)

(defmacro concat (result key val)
  `(setf ,result (concatenate 'string ,result
                              (format nil "+~(~a~):~a" ,key ,val))))

(defun google-query (string keys)
  (let ((query (concatenate 'string "https://google.com/search?q=" string)))
    (loop for key in keys by #'cddr
          for value in (cdr keys) by #'cddr
          when value do (concat query key value))
    query))

(defun google (string &rest keys &key &allow-other-keys)
  (let ((query (google-query string keys)))
    (ss:parse query)))
