;9)Escribir un programa que implemente el siguiente fragmento escrito en un lenguaje de alto nivel:
; Ejecutar con la opción Delay Slot habilitada.
;
;      while a > 0 do begin
;         x := x + y;
;         a := a - 1;
;      end;

        .data
        A: .word 3        ; Variable A con valor inicial 3
        X: .word 0        ; Variable X con valor inicial 0
        Y: .word 2        ; Variable Y con valor inicial 2
        RES: .word 0      ; Espacio para almacenar el resultado final

        .code
        ld R1, A(R0)   ; Cargar A en R1
        ld R2, X(R0)   ; Cargar X en R2
        ld R3, Y(R0)   ; Cargar Y en R3

SEGUIR: beq R1, R0, FIN  ; Si A (R1) es 0, termina
        dadd R2, R2, R3  ; X = X + Y
        sd R2, RES(R0)   ; Guardar el nuevo valor de X en RES
        daddi R1, R1, -1 ; Decrementar A (R1) en 1
        j SEGUIR         ; Saltar de nuevo al ciclo    
   FIN: halt             ; Detener la ejecución
