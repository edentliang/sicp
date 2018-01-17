(load "46-fixed-point.scm")

(define (sqrt x)
  (fixed-point (lambda(y) (/ (+ y (/ x y)) 2)) 1.0))
