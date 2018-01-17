(define (iterative-improve close-enough? improve)
  (lambda (first-guess)
    (define (try guess)
      (let ((next (imrpove guess)))
        (if (close-enough? guess next)
          next
          (try next))))
    (try first-guess)))

