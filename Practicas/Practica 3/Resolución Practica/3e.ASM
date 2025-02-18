;e) Ingresar 5 caracteres por teclado y enviarlos a la impresora en orden normal y luego inverso a través del HAND-SHAKE en modo interrupciones:

ORG 1000H
; Ingresar 5 caracteres y enviarlos a la impresora en orden normal y luego inverso (HandShake con Interrupciones)

MOV CX, 5            ; Número de caracteres
MOV BX, 0            ; Contador para almacenar caracteres

INPUT_CHAR:
    MOV AH, 01H      ; Leer un carácter desde el teclado
    INT 21H          ; Esperar la entrada
    MOV [BX], DL     ; Guardar carácter
    INC BX
    LOOP INPUT_CHAR  ; Repetir para 5 caracteres

; Habilitar interrupciones
MOV AL, 01H          ; Habilitar interrupciones
OUT 20H, AL

; Imprimir en orden normal
MOV SI, OFFSET 0
PRINT_NORMAL:
    MOV AL, [SI]
    OUT 31H, AL      ; Enviar a la impresora

    ; Esperar interrupción (deja que la impresora gestione la espera)
    JMP PRINT_NORMAL

; Imprimir en orden inverso
MOV BX, 4
PRINT_REVERSE:
    MOV AL, [BX]
    OUT 31H, AL      ; Enviar a la impresora
    DEC BX
    JMP PRINT_REVERSE

JMP $
END
