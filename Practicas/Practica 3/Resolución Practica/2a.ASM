;a) Imprimir la letra "A" utilizando la impresora a través de la PIO:

ORG 1000H
; Imprimir la letra "A" en la impresora
MOV AL, 'A'          ; Cargar la letra "A" en AL
OUT 31H, AL          ; Enviar el valor al puerto PB (Puerto de datos de la impresora)

; Esperar a que la impresora no esté ocupada (busy=0)
CHECK_BUSY:
    IN AL, 20H       ; Leer el estado de la impresora desde el puerto PA
    TEST AL, 01H     ; Comprobar si el bit 0 (busy) está encendido
    JZ CHECK_BUSY    ; Si está ocupado, seguir esperando

; Enviar el strobe para indicar que hay un nuevo dato
MOV AL, 02H          ; Preparar el valor para el strobe (bit 1)
OUT 20H, AL          ; Enviar strobe al puerto PA

; Terminar el envío de datos
MOV AL, 00H
OUT 20H, AL          ; Limpiar el strobe

JMP $

END
