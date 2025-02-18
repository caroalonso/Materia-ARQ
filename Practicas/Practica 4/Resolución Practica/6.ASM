;6) Escribir un programa que lea tres números enteros A, B y C de la memoria de datos y determine cuántos de ellos son iguales
; entre sí (0, 2 o 3). El resultado debe quedar almacenado en la dirección de memoria D.

            .data
            A: .word 1
            B: .word 2
            C: .word 2
            D: .word 0

            .code
            ld r1, A(r0)              ; cargar A en r1
            ld r2, B(r0)              ; cargar B en r2
            ld r3, C(r0)              ; cargar C en r3
            daddi r4, r0, 0           ; r4 = 0 (ningún número igual aún)
            daddi r5, r0, 2           ; r5 = 2 (dos números iguales)
            daddi r6, r0, 3           ; r6 = 3 (todos los números iguales)
            beq r1, r2, probartres    ; si A == B, saltar a probartres
            beq r2, r3, dosiguales    ; si B == C, saltar a dosiguales
            j cero                    ; si no son iguales, saltar a cero
probartres: beq r2, r3, tres          ; si B == C, entonces A, B y C son iguales
            j dosiguales              ; si solo A == B, saltar a dosiguales
dosiguales: sd r5, D(r0)              ; guardar el valor 2 en D
            j fin                     ; saltar a fin
     tres:  sd r6, D(r0)              ; guardar el valor 3 en D
            j fin                     ; saltar a fin
      cero: sd r4, D(r0)              ; guardar el valor 0 en D (ningún número igual)
       fin: halt                      ; terminar el programa
