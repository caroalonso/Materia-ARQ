;7) Modificar la subrutina del ejercicio 5 para que cuente la cantidad de veces que se repite un dado caracter en una
; cadena. Además, la subrutina debe cambiar el caracter especificado por una "X". El caracter a buscar se debe pasar por
; valor mientras que la cadena a analizar por referencia a través de la pila. 

       ORG 1000H
FRASE  DB  "AzAytA", 0        ; Cadena de caracteres



       ORG 3000H
CONCAR:
       POP  AX                ; Recuperar el carácter a buscar en AL
       POP  BX                ; Recuperar la dirección de la cadena en BX

CONCAR_LOOP:
       CMP  byte ptr [BX], 0   ; Comprobar si es el fin de la cadena (0)
       JZ   FIN                ; Si es 0, saltar a FIN
       CMP  byte ptr [BX], AL  ; Comparar el carácter de la cadena con AL
       JZ   REEMPLAZAR         ; Si es igual, ir a reemplazar

       INC  BX                 ; Mover al siguiente carácter de la cadena
       JMP  CONCAR_LOOP        ; Repetir el ciclo

REEMPLAZAR:
       INC  CX                 ; Incrementar el contador de ocurrencias
       MOV  byte ptr [BX], 'X' ; Reemplazar el carácter por 'X'
       INC  BX                 ; Mover al siguiente carácter de la cadena
       JMP  CONCAR_LOOP        ; Repetir el ciclo

FIN:
       RET                     ; Regresar al programa principal


       ORG 2000H
       MOV  BX, OFFSET FRASE  ; Dirección de la cadena a BX
       MOV  AL, 'A'           ; Carácter a buscar (pasado por valor)
       MOV  CX, 0             ; Inicializar el contador a 0
       
       PUSH BX                ; Poner la dirección de la cadena en la pila
       PUSH AX                ; Poner el carácter a buscar en la pila
       
       CALL CONCAR            ; Llamar a la subrutina CONCAR

       HLT                     ; Fin del programa
       END





