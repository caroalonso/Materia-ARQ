;c) Solicitar el ingreso de cinco caracteres por teclado y enviarlos a la impresora:

ORG 1000H
; Ingresar 5 caracteres desde el teclado y enviarlos a la impresora
MOV CX, 5            ; Contador para 5 caracteres
INPUT_CHAR:
    MOV AH, 01H      ; Leer un carácter desde el teclado
    INT 21H          ; Esperar la entrada del teclado
    MOV AL, DL       ; Guardar el carácter ingresado

    OUT 31H, AL      ; Enviar el carácter a la impresora

    ; Esperar que la impresora no esté ocupada (busy=0)
CHECK_BUSY:
    IN AL, 20H       ; Leer el estado de la impresora desde el puerto PA
    TEST AL, 01H     ; Comprobar si el bit 0 (busy) está encendido
    JZ CHECK_BUSY    ; Si está ocupado, seguir esperando

    MOV AL, 02H      ; Enviar strobe
    OUT 20H, AL

    MOV AL, 00H      ; Limpiar el strobe
    OUT 20H, AL

    LOOP INPUT_CHAR  ; Decrementar CX y repetir hasta 5 caracteres

JMP $
END
