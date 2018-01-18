(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object)
  
  (eq? (car object) 'leaf))

(define (symbol-leaf x)
  (cadr x))

(define (weight-leaf x)
  (caddr x))

(define (make-code-tree left right)
  (list left
        right
        (append (symbol left) (symbol right))
        (+ (weight left) (weight right))
        ))

(define (symbol tree)
  (if (leaf? tree)
    (list (symbol-leaf tree))
    (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
    (weight-leaf tree)
    (cadddr tree)))

(define (decode bits tree)
  (define (decode-1 bits cur-branch)
    (if (null? bit)
      '()
      (let ((next-branch 
              (choose-branch (car bits) cur-branch)))
        (if (leaf? next-branch)
          (cons (symbol-leaf next-branch)
                (decode (cdr bits) tree))
          (decode-1 bits next-branch)))))
  (decode-1 bits tree))

(define (choose-branch bit tree)
  (cond ((= bit 0) (left-branch tree)
        ((= bit 1) (right-bran tree))
        (else (error "error")))))

(define (left-branch x)
  (car x))

(define (right-branch x)
  (cadr x))

