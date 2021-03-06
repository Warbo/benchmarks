(declare-datatypes (a)
  ((list (nil) (cons (head a) (tail (list a))))))
(declare-datatypes (a)
  ((Tree (Node (Node_0 (Tree a)) (Node_1 a) (Node_2 (Tree a)))
     (Nil))))
(define-fun-rec
  zelem
    ((x Int) (y (list Int))) Bool
    (match y
      (case nil false)
      (case (cons z ys) (or (= x z) (zelem x ys)))))
(define-fun-rec
  swap
    ((x Int) (y Int) (z (Tree Int))) (Tree Int)
    (match z
      (case (Node p x2 q)
        (ite
          (= x2 x) (Node (swap x y p) y (swap x y q))
          (ite
            (= x2 y) (Node (swap x y p) x (swap x y q))
            (Node (swap x y p) x2 (swap x y q)))))
      (case Nil (as Nil (Tree Int)))))
(define-fun-rec
  (par (a)
    (append
       ((x (list a)) (y (list a))) (list a)
       (match x
         (case nil y)
         (case (cons z xs) (cons z (append xs y)))))))
(define-fun-rec
  (par (a)
    (flatten0
       ((x (Tree a))) (list a)
       (match x
         (case (Node p y q)
           (append (append (flatten0 p) (cons y (as nil (list a))))
             (flatten0 q)))
         (case Nil (as nil (list a)))))))
(assert-not
  (forall ((p (Tree Int)) (a Int) (b Int))
    (=> (zelem a (flatten0 p))
      (=> (zelem b (flatten0 p))
        (and (zelem a (flatten0 (swap a b p)))
          (zelem b (flatten0 (swap a b p))))))))
(check-sat)
