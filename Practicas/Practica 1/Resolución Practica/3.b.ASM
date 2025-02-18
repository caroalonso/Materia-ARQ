;b) Con subrutina SUM32 pasando parámetros por valor a través de registros
;Se pasan los números en registros y la subrutina SUM32 realiza la suma.

        ORG 1000H  ; Memoria de datos
NUM1    DW 9234H
        DW 1111H
NUM2    DW 9234H
        DW 2222H
RESULT  DW ?       
        DW ?

        ORG 3000H  ; Subrutina SUM32
SUM32:  ADD AX, CX    ; Sumar partes bajas
        ADC DX, BX    ; Sumar partes altas con acarreo
        RET

        ORG 2000H  ; Programa principal
        MOV AX, NUM1
        MOV DX, NUM1+2
        MOV CX, NUM2
        MOV BX, NUM2+2

        CALL SUM32    ; Llamar a la subrutina de suma

        MOV RESULT, AX  ; Guardar parte baja del resultado
        MOV RESULT+2, DX ; Guardar parte alta del resultado

        HLT
        END
