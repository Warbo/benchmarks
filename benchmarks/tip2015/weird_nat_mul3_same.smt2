; Weird functions over natural numbers
;
; Property about a trinary multiplication function, defined in terms of an
; accumulative trinary addition function
; mul3acc x y z = xyz + (xy + xz + yz) + (x + y + z) + 1
(declare-datatypes () ((Nat (Z) (S (p Nat)))))
(define-funs-rec
  ((add3acc ((x Nat) (y Nat) (z Nat)) Nat))
  ((match x
     (case Z
       (match y
         (case Z z)
         (case (S y2) (add3acc Z y2 (S z)))))
     (case (S x2) (add3acc x2 (S y) z)))))
(define-funs-rec
  ((mul3acc ((x Nat) (y Nat) (z Nat)) Nat))
  ((match x
     (case Z Z)
     (case (S x2)
       (match y
         (case Z Z)
         (case (S x3)
           (match z
             (case Z Z)
             (case (S x4)
               (match x2
                 (case Z
                   (match x3
                     (case Z
                       (match x4
                         (case Z (S Z))
                         (case (S x5)
                           (S
                             (add3acc (mul3acc Z Z x4)
                               (add3acc (mul3acc (S Z) Z x4)
                                 (mul3acc Z (S Z) x4) (mul3acc Z Z (S Z)))
                               (add3acc Z Z x4))))))
                     (case (S x6)
                       (S
                         (add3acc (mul3acc Z x3 x4)
                           (add3acc (mul3acc (S Z) x3 x4)
                             (mul3acc Z (S Z) x4) (mul3acc Z x3 (S Z)))
                           (add3acc Z x3 x4))))))
                 (case (S x7)
                   (S
                     (add3acc (mul3acc x2 x3 x4)
                       (add3acc (mul3acc (S Z) x3 x4)
                         (mul3acc x2 (S Z) x4) (mul3acc x2 x3 (S Z)))
                       (add3acc x2 x3 x4)))))))))))))
(define-funs-rec
  ((add3 ((x Nat) (y Nat) (z Nat)) Nat))
  ((match x
     (case Z
       (match y
         (case Z z)
         (case (S y2) (S (add3 Z y2 z)))))
     (case (S x2) (S (add3 x2 y z))))))
(define-funs-rec
  ((mul3 ((x Nat) (y Nat) (z Nat)) Nat))
  ((match x
     (case Z Z)
     (case (S x2)
       (match y
         (case Z Z)
         (case (S x3)
           (match z
             (case Z Z)
             (case (S x4)
               (match x2
                 (case Z
                   (match x3
                     (case Z
                       (match x4
                         (case Z (S Z))
                         (case (S x5)
                           (S
                             (add3 (mul3 Z Z x4)
                               (add3 (mul3 (S Z) Z x4) (mul3 Z (S Z) x4) (mul3 Z Z (S Z)))
                               (add3 Z Z x4))))))
                     (case (S x6)
                       (S
                         (add3 (mul3 Z x3 x4)
                           (add3 (mul3 (S Z) x3 x4) (mul3 Z (S Z) x4) (mul3 Z x3 (S Z)))
                           (add3 Z x3 x4))))))
                 (case (S x7)
                   (S
                     (add3 (mul3 x2 x3 x4)
                       (add3 (mul3 (S Z) x3 x4) (mul3 x2 (S Z) x4) (mul3 x2 x3 (S Z)))
                       (add3 x2 x3 x4)))))))))))))
(assert-not
  (forall ((x Nat) (y Nat) (z Nat))
    (= (mul3 x y z) (mul3acc x y z))))
(check-sat)
