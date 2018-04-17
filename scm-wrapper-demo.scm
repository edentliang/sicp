; -*-  indent-tabs-mode:nil ; coding: utf-8 -*-
;; @Copyright Dorabot Inc.
;; @date : 2018
;; @author :
;; @brief :

(define-module (dorabot scm-wrapper-demo)
  #:use-module (system foreign)
  #:export (define-c-func)
           (ffi-binding)
           (str->ptr)
           (define-box-type)
           (make-box-type)
           (unbox-type))

(define clib (make-parameter (dynamic-link)))

(define-syntax define-c-function
  (lambda (x)
    (syntax-case x ()
    ((_ type name)
     #`(module-define!
        (current-module)
        '#,(datum->syntax #'name (symbol-append '% (syntax->datum #'name)))
        (pointer->procedure type
                            (dynamic-func (symbol->string 'name) (clib))
                            '()
                            #:return-errno? #t)))
    ((_ type name (para ...))
     #`(module-define!
        (current-module)
        '#,(datum->syntax #'name (symbol-append '% (syntax->datum #'name)))
        (pointer->procedure type
                            (dynamic-func (symbol->string 'name) (clib))
                            (list para ...)
                            #:return-errno? #t))))))

(define-syntax-rule (ffi-binding libname body ...)
  (parameterize ((clib (dynamic-link libname)))
    body ...
    #t))

(define-syntax-rule (str->ptr name)
    (string->pointer name "utf-8"))

(define-syntax-rule (define-box-type name)
  (define-record-type name (fields treasure)))

(define-macro (make-box-type bt v)
  (list (symbol-append 'make- bt) v))

(define-syntax-rule (box-type-treasure t)
  (record-accessor (record-rtd t) 0))

(define-syntax-rule (unbox-type t)
  (let ((treasure-getter (box-type-treasure t)))
    (treasure-getter t)))
