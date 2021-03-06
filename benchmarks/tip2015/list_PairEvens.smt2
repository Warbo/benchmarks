(declare-datatypes (a)
  ((list (nil) (cons (head a) (tail (list a))))))
(declare-datatypes (a b) ((Pair (Pair2 (first a) (second b)))))
(declare-datatypes () ((Nat (Z) (S (p Nat)))))
(define-fun-rec
  (par (t)
    (pairs
       ((x (list t))) (list (Pair t t))
       (match x
         (case nil (as nil (list (Pair t t))))
         (case (cons y z)
           (match z
             (case nil (as nil (list (Pair t t))))
             (case (cons y2 xs) (cons (Pair2 y y2) (pairs xs)))))))))
(define-fun-rec
  (par (a b)
    (map2
       ((x (=> a b)) (y (list a))) (list b)
       (match y
         (case nil (as nil (list b)))
         (case (cons z xs) (cons (@ x z) (map2 x xs)))))))
(define-fun-rec
  (par (a)
    (length
       ((x (list a))) Nat
       (match x
         (case nil Z)
         (case (cons y xs) (S (length xs)))))))
(define-fun
  (par (a b)
    (fst ((x (Pair a b))) a (match x (case (Pair2 y z) y)))))
(define-funs-rec
  ((par (a) (evens ((x (list a))) (list a)))
   (par (a) (odds ((x (list a))) (list a))))
  ((match x
     (case nil (as nil (list a)))
     (case (cons y xs) (cons y (odds xs))))
   (match x
     (case nil (as nil (list a)))
     (case (cons y xs) (evens xs)))))
(define-fun-rec
  even
    ((x Nat)) Bool
    (match x
      (case Z true)
      (case (S y)
        (match y
          (case Z false)
          (case (S z) (even z))))))
(assert-not
  (par (b)
    (forall ((xs (list b)))
      (=> (even (length xs))
        (= (map2 (lambda ((x (Pair b b))) (fst x)) (pairs xs))
          (evens xs))))))
(check-sat)
