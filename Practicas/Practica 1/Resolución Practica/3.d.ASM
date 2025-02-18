;Con subrutina SUM32 pasando parámetros por valor y por referencia a través de la pila
;En este caso, los números se pasan por valor y la dirección del resultado se pasa por referencia.

        ORG 1000H  ; Memoria de datos
NUM1    DW 9234H
        DW 1111H
NUM2    DW 9234H
        DW 2222H
RESULT  DW ?
        DW ?

        ORG 3000H  ; Subrutina SUM32
SUM32:  PUSH BX
        PUSH CX
        PUSH AX
        PUSH DX

        MOV BX, SP
        ADD BX, 8   ; Apuntar al primer número (NUM1)
        MOV AX, [BX]
        ADD BX, 2
        MOV DX, [BX]

        ADD BX, 2   ; Apuntar al segundo número (NUM2)
        MOV CX, [BX]
        ADD BX, 2
        MOV BX, [BX] ; Apuntar a RESULT

        ADD AX, CX  ; Sumar partes bajas
        ADC DX, [BX+2] ; Sumar partes altas con acarreo
        MOV [BX], AX  ; Guardar parte baja
        MOV [BX+2], DX ; Guardar parte alta

        POP DX
        POP AX
        POP CX
        POP BX
        RET

        ORG 2000H  ; Programa principal
        MOV AX, NUM1
        PUSH AX
        MOV AX, NUM1+2
        PUSH AX
        MOV AX, NUM2
        PUSH AX
        MOV AX, NUM2+2
        PUSH AX
        MOV AX, OFFSET RESULT
        PUSH AX

        CALL SUM32

        ADD SP, 10   ; Limpiar la pila

        HLT
        END
