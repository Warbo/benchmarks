; Weird functions over natural numbers
;
; Property about a 4-adic operation over natural numbers
; op a b c d = a * b + c + d
(declare-datatypes () ((Nat (Z) (S (p Nat)))))
(define-fun-rec
  op
    ((x Nat) (y Nat) (z Nat) (x2 Nat)) Nat
    (match x
      (case Z
        (match z
          (case Z x2)
          (case (S x3) (op Z y x3 (S x2)))))
      (case (S x4)
        (match z
          (case Z (op x4 y y x2))
          (case (S c) (op x y c (S x2)))))))
(assert-not
  (forall ((a Nat) (b Nat) (c Nat) (d Nat) (e Nat))
    (= (op (op a b Z Z) c d e) (op a (op b c Z Z) d e))))
(check-sat)
