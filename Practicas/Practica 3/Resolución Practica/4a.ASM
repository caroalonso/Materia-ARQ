;a) Imprimir el carácter "A" en la impresora a través de la USART usando el protocolo DTR. La comunicación es por consulta de estado.

ORG 1000H
; Imprimir "A" usando USART con protocolo DTR (consulta de estado)

MOV AL, 'A'        ; Cargar el carácter 'A' en AL
; Configurar USART para el protocolo DTR (dependiendo de cómo esté configurado el USART)
; Suponemos que los puertos correspondientes y el protocolo DTR están configurados previamente.

WAIT_READY:
    IN AL, 20H     ; Leer el estado de la USART (consultar si está lista para enviar)
    TEST AL, 01H   ; Verificar si el bit de "Listo" está activado
    JZ WAIT_READY  ; Si no está listo, continuar esperando

    OUT 30H, AL    ; Enviar carácter 'A' a la impresora a través de USART (DTR)

JMP $
END
