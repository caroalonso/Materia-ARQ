;1)muestre en la pantalla de comandos un
; mensaje previamente almacenado en memoria de datos, aplicando la interrupción por software INT 7


ORG 1000H            ; Dirección de inicio del programa
MSJ DB "ARQUITECTURA DE COMPUTADORAS-" ; Mensaje a mostrar
    DB "FACULTAD DE INFORMATICA-"     ; Continuación del mensaje
    DB 55H, 4EH, 4CH, 50H             ; Valores en hexadecimal que podrían ser parte del mensaje
FIN DB ?               ; Valor para marcar el final del mensaje


ORG 2000H            ; Dirección de inicio del código
MOV BX, OFFSET MSJ   ; Cargar la dirección del mensaje en el registro BX
MOV AL, OFFSET FIN-OFFSET MSJ  ; Calcular la longitud del mensaje (FIN - MSJ)
INT 7                ; Llamar a la interrupción INT 7 para mostrar el mensaje
INT 0                ; Terminar el programa
END
