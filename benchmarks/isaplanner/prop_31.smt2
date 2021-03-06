; Property from "Case-Analysis for Rippling and Inductive Proof",
; Moa Johansson, Lucas Dixon and Alan Bundy, ITP 2010
(declare-datatypes () ((Nat (Z) (S (p Nat)))))
(define-fun-rec
  min2
    ((x Nat) (y Nat)) Nat
    (match x
      (case Z Z)
      (case (S z)
        (match y
          (case Z Z)
          (case (S y2) (S (min2 z y2)))))))
(assert-not
  (forall ((a Nat) (b Nat) (c Nat))
    (= (min2 (min2 a b) c) (min2 a (min2 b c)))))
(check-sat)
