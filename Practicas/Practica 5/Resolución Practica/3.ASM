;3) Escribir un programa que calcule la superficie de un triángulo rectángulo de base 5,85 cm y altura 13,47 cm.Pista: la
;superficie de un triángulo se calcula como:
;Superficie = (base x altura) / 2

        .data
base:   .double 5.85
altura: .double 13.47
sup:    .double 0.0

       .code
        l.d f1, base(R0)
        l.d f2, altura(R0)
        mul.d f3, f2, f1 ; f3 = base * altura
        daddi r2, r0, 2
        mtc1 r2, f4
        cvt.d.l f5, f4 ; f5 = 2.0
        div.d f6, f3, f5 ; f6 = base * altura / 2
        s.d f6, superficie(r0)
        Halt
