;a) Sin hacer llamados a subrutinas
;Este código resuelve la suma directamente en el programa principal.

        ORG 1000H  ; Memoria de datos
NUM1    DW 9234H
        DW 1111H
NUM2    DW 9234H
        DW 2222H
RESULT  DW ?       ; Espacio para la parte baja del resultado
        DW ?       ; Espacio para la parte alta del resultado

        ORG 2000H  ; Programa principal
        MOV AX, NUM1     ; Cargar parte baja de NUM1
        ADD AX, NUM2     ; Sumar parte baja de NUM2
        MOV RESULT, AX   ; Guardar parte baja del resultado

        MOV DX, NUM1+2   ; Cargar parte alta de NUM1
        ADC DX, NUM2+2   ; Sumar parte alta de NUM2 con acarreo
        MOV RESULT+2, DX ; Guardar parte alta del resultado

        HLT
        END
