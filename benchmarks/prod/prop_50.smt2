; Property from "Productive Use of Failure in Inductive Proof",
; Andrew Ireland and Alan Bundy, JAR 1996
;
; This property is the same as isaplanner #53
(declare-datatypes (a)
  ((list (nil) (cons (head a) (tail (list a))))))
(declare-datatypes () ((Nat (Z) (S (p Nat)))))
(define-fun-rec
  le
    ((x Nat) (y Nat)) Bool
    (match x
      (case Z true)
      (case (S z)
        (match y
          (case Z false)
          (case (S x2) (le z x2))))))
(define-fun-rec
  insert2
    ((x Nat) (y (list Nat))) (list Nat)
    (match y
      (case nil (cons x (as nil (list Nat))))
      (case (cons z xs)
        (ite (le x z) (cons x y) (cons z (insert2 x xs))))))
(define-fun-rec
  isort
    ((x (list Nat))) (list Nat)
    (match x
      (case nil (as nil (list Nat)))
      (case (cons y xs) (insert2 y (isort xs)))))
(define-fun-rec
  equal
    ((x Nat) (y Nat)) Bool
    (match x
      (case Z
        (match y
          (case Z true)
          (case (S z) false)))
      (case (S x2)
        (match y
          (case Z false)
          (case (S y2) (equal x2 y2))))))
(define-fun-rec
  count
    ((x Nat) (y (list Nat))) Nat
    (match y
      (case nil Z)
      (case (cons z xs)
        (ite (equal x z) (S (count x xs)) (count x xs)))))
(assert-not
  (forall ((x Nat) (y (list Nat)))
    (= (count x (isort y)) (count x y))))
(check-sat)
