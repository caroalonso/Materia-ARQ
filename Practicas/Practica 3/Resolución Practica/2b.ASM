;b) Imprimir el mensaje "ORGANIZACION Y ARQUITECTURA DE COMPUTADORAS" utilizando la impresora a través de la PIO:

ORG 1000H
; Mensaje a imprimir
MSG DB 'ORGANIZACION Y ARQUITECTURA DE COMPUTADORAS', 0

MOV SI, OFFSET MSG    ; Cargar la dirección del mensaje
PRINT_CHAR:
    MOV AL, [SI]      ; Cargar el siguiente carácter en AL
    INC SI            ; Avanzar al siguiente carácter

    CMP AL, 00        ; Verificar si es el fin del mensaje
    JE FIN            ; Si es 0, fin del mensaje

    OUT 31H, AL       ; Enviar el carácter a la impresora

    ; Esperar que la impresora no esté ocupada (busy=0)
CHECK_BUSY:
    IN AL, 20H        ; Leer el estado de la impresora desde el puerto PA
    TEST AL, 01H      ; Comprobar si el bit 0 (busy) está encendido
    JZ CHECK_BUSY     ; Si está ocupado, seguir esperando

    MOV AL, 02H       ; Enviar strobe
    OUT 20H, AL

    MOV AL, 00H       ; Limpiar el strobe
    OUT 20H, AL

    JMP PRINT_CHAR    ; Repetir para el siguiente carácter

FIN:
JMP $
END


