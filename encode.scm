(load "huffman.scm")
(define sample-tree
        (make-code-tree (make-leaf 'A 4)
                        (make-code-tree
                            (make-leaf 'B 2)
                            (make-code-tree (make-leaf 'D 1)
                                            (make-leaf 'C 1)))))
(define (encode-symbol mesg tree)
  (cond ((leaf? tree) '())
        ((symbol-in-tree? mesg (left-branch tree))
         (cons 0
               (encode-symbol mesg (left-branch tree))))
        ((symbol-in-tree? mesg (right-branch tree))
         (cons 1
               (encode-symbol mesg (right-branch tree))))
        (else (error "error"))))

(define (symbol-in-tree? mesg tree)
  (define (findsym mesg sym )
    (cond ((null? sym) #f)
          ((eq? mesg (car sym)) #t)
          (else (findsym mesg (cdr sym)))))
  (findsym mesg (symbol tree)))
