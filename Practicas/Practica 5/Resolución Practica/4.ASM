
                .data
            INF:    .double 18.5
            NOR:    .double 25.0
            SOB:    .double 30
            Peso:   .double 61.95
            Altura: .double 1.6
            IMC:    .double 0.0
            Estado: .word 0

                .code
            L.D F1, INF(R0)
            L.D F2, NOR(R0)
            L.D F3, SOB(R0)
            L.D F4, Peso(R0)
            L.D F5, Altura(R0)
            MUL.D F6, F5, F5
            DIV.D F7, F4, F6
            c.lt.d F1, F7
            bc1f Infrapeso
            c.lt.d F2, F7
            bc1f Normal
            c.lt.d F3, F7
            bc1f Sobrepeso
            S.D F7, IMC(R0)
            DADDI R1, R0, 4 
            SD R1, Estado(R0)
            J FIN
 Infrapeso: S.D F7, IMC(R0)
            DADDI R1, R0, 1
            SD R1, Estado(R0)
            J FIN
    Normal: S.D F7, IMC(R0)
            DADDI R1, R0, 2
            SD R1, Estado(R0)
            J FIN
 Sobrepeso: S.D F7, IMC(R0)
            DADDI R1, R0, 3
            SD R1, Estado(R0)
       FIN: HALT