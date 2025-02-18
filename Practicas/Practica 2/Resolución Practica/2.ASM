; Escribir un programa que muestre en pantalla todos los caracteres disponibles en el simulador MSX88, comenzando con
; el caracter cuyo código es el número 01H.

        ORG 1000H                ; Dirección de inicio del programa
        MENSAJE DB 01H           ; Primer carácter a imprimir (01H)

         ORG 2000H               ; Dirección de la subrutina
         MOV BX, OFFSET MENSAJE  ; Cargar la dirección de MENSAJE en BX
REPETIR: MOV DL, [BX]            ; Cargar el carácter en DL desde la dirección apuntada por BX,para poder imprimir INT7
         INT 7                   ; Llamada a la interrupción para imprimir el carácter en pantalla
         INC BX                  ; Incrementar el puntero para la siguiente dirección de carácter
         CMP BYTE PTR [BX], 7FH  ; Comprobar si el carácter es 7FH (el último)
         JNZ REPETIR             ; Si no es 7FH, continuar con el siguiente carácter

         INT 0                   ; Finaliza el programa
         END
