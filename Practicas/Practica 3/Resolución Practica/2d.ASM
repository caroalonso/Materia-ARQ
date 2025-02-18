;d) Solicitar ingresar caracteres por teclado y enviarlos a la impresora cuando se presione F10:

ORG 1000H
; Ingresar caracteres por teclado y enviarlos a la impresora al presionar F10
MOV BX, 0            ; Contador de caracteres

WAIT_FOR_F10:
    MOV AH, 01H      ; Leer un carácter desde el teclado
    INT 21H          ; Esperar la entrada del teclado

    CMP DL, 0F0H     ; Comprobar si la tecla presionada es F10
    JZ SEND_TO_PRINTER

    ; Almacenar el carácter ingresado en memoria (no se muestra en pantalla)
    MOV [BX], DL
    INC BX
    JMP WAIT_FOR_F10

SEND_TO_PRINTER:
    ; Enviar los caracteres almacenados a la impresora
    MOV SI, OFFSET BX
SEND_CHAR:
    MOV AL, [SI]     ; Cargar el siguiente carácter
    INC SI           ; Avanzar al siguiente carácter

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

    CMP AL, 0F0H     ; Verificar si es el último carácter
    JNZ SEND_CHAR    ; Si no es el último carácter, continuar

JMP $
END
