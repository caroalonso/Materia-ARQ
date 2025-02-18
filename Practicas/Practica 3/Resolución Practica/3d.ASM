;d) Ingresar 5 caracteres por teclado y enviarlos a la impresora en orden normal y luego en orden inverso a través del HAND-SHAKE en modo consulta de estado:

ORG 1000H
; Ingresar 5 caracteres y enviarlos a la impresora en orden normal y luego inverso

MOV CX, 5            ; Número de caracteres
MOV BX, 0            ; Contador para almacenar caracteres

INPUT_CHAR:
    MOV AH, 01H      ; Leer un carácter desde el teclado
    INT 21H          ; Esperar la entrada
    MOV [BX], DL     ; Guardar el carácter en memoria
    INC BX
    LOOP INPUT_CHAR  ; Repetir para 5 caracteres

; Imprimir en orden normal
MOV SI, OFFSET 0     ; Dirección de inicio
PRINT_NORMAL:
    MOV AL, [SI]
    OUT 31H, AL      ; Enviar a la impresora
    IN AL, 20H       ; Esperar "busy"=0
    TEST AL, 01H
    JZ PRINT_NORMAL

    INC SI           ; Siguiente carácter

; Imprimir en orden inverso
MOV BX, 4            ; Dirección del último carácter almacenado
PRINT_REVERSE:
    MOV AL, [BX]
    OUT 31H, AL      ; Enviar a la impresora
    IN AL, 20H       ; Esperar "busy"=0
    TEST AL, 01H
    JZ PRINT_REVERSE

    DEC BX           ; Siguiente carácter hacia atrás

JMP $
END
