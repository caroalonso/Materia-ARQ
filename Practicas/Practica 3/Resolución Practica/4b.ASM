;b) Imprimir la cadena "USART DTR POLLING" en la impresora a través de la USART usando el protocolo DTR. La comunicación es por consulta de estado

ORG 1000H
; Imprimir "USART DTR POLLING" usando USART con protocolo DTR (consulta de estado)

MSG DB 'USART DTR POLLING', 0  ; Mensaje a imprimir
MOV SI, OFFSET MSG             ; Dirección del mensaje

PRINT_CHAR:
    MOV AL, [SI]               ; Cargar el siguiente carácter
    INC SI                     ; Avanzar al siguiente carácter

    CMP AL, 00                 ; Verificar si es el fin del mensaje
    JE FIN                     ; Si es 0, fin del mensaje

WAIT_READY:
    IN AL, 20H                 ; Leer el estado de la USART (consultar si está lista)
    TEST AL, 01H               ; Verificar si está lista para enviar
    JZ WAIT_READY              ; Si no está lista, seguir esperando

    OUT 30H, AL                ; Enviar el carácter a la impresora a través de USART

    JMP PRINT_CHAR             ; Repetir para el siguiente carácter

FIN:
JMP $
END
