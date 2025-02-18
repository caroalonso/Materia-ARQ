;6) Escribir una subrutina SWAP que intercambie dos datos de 16 bits almacenados en memoria. Los parámetros deben
; ser pasados por referencia desde el programa principal a través de la pila

ORG 1000H
    PARAM1     DW       1234H        ; Primer parámetro
    PARAM2     DW       5ABCH        ; Segundo parámetro

ORG 3000H
SWAP:
    ; Extraer los valores de la pila
    POP     BX              ; Extrae el primer parámetro (PARAM1) a BX
    POP     DX              ; Extrae el segundo parámetro (PARAM2) a DX

    ; Intercambio de los valores
    PUSH    DX              ; Coloca el valor de PARAM2 (DX) en la pila
    PUSH    BX              ; Coloca el valor de PARAM1 (BX) en la pila

    RET                     ; Retorna al programa principal

ORG 2000H
    MOV     AX, OFFSET PARAM1   ; Cargar la dirección de PARAM1 en AX
    PUSH    AX                  ; Pasa la dirección de PARAM1 por la pila
    MOV     AX, OFFSET PARAM2   ; Cargar la dirección de PARAM2 en AX
    PUSH    AX                  ; Pasa la dirección de PARAM2 por la pila
    CALL    SWAP                ; Llama a la subrutina SWAP
    HLT                         ; Detiene la ejecución del programa
END
