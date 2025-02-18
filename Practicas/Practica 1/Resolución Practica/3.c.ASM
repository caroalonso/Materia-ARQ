;c) Con subrutina SUM32 pasando parámetros por referencia a través de registros
;En este caso, pasamos las direcciones de memoria de los números en lugar de sus valores.

        ORG 1000H  ; Memoria de datos
NUM1    DW 9234H
        DW 1111H
NUM2    DW 9234H
        DW 2222H
RESULT  DW ?
        DW ?

        ORG 3000H  ; Subrutina SUM32
SUM32:  MOV AX, [SI]    ; Cargar parte baja de NUM1
        ADD AX, [DI]    ; Sumar parte baja de NUM2
        MOV [BX], AX    ; Guardar parte baja del resultado

        MOV DX, [SI+2]  ; Cargar parte alta de NUM1
        ADC DX, [DI+2]  ; Sumar parte alta de NUM2 con acarreo
        MOV [BX+2], DX  ; Guardar parte alta del resultado

        RET

        ORG 2000H  ; Programa principal
        MOV SI, OFFSET NUM1  ; Cargar dirección de NUM1
        MOV DI, OFFSET NUM2  ; Cargar dirección de NUM2
        MOV BX, OFFSET RESULT ; Dirección donde se guardará el resultado

        CALL SUM32

        HLT
        END
