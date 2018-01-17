(define (menq item x)
  (cond ((null? x ) false)
        ((eq? item (car x)) x)
        (else (menq item (cdr x)))))
