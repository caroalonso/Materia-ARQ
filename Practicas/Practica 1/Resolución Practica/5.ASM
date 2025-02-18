;5) Escribir una subrutina CONCAR que cuente el número de caracteres de una cadena de caracteres terminada en cero
; (00H) almacenada en la memoria del microprocesador. La cadena se pasa a la subrutina por referencia vía registro.

        ORG 1000H
FRASE   DB  "AzAytA",0         ;Cadena de caracteres terminada en 0 (NULL)

        ORG 3000H
CONCAR: CMP  byte ptr [BX], 0  ;Compara el byte apuntado por BX con 0 (fin de cadena)
        JZ   FIN               ;Si el byte es 0, saltamos a FIN (fin de la cadena)
        INC  CX                ;Incrementa el contador de caracteres (CX)
        INC  BX                ;Incrementa el puntero de la cadena (BX)
        JMP  CONCAR            ;Salta a la etiqueta CONCAR (ciclo para seguir contando)
FIN:    RET                    ; Retorna de la subrutina cuando la cadena termina

        ORG 2000H
        MOV  BX, OFFSET FRASE  ;Carga la dirección de la cadena en BX (puntero a FRASE)
        MOV  CX, 0             ;Inicializa el contador de caracteres (CX) en 0
        CALL CONCAR            ;Llama a la subrutina CONCAR para contar los caracteres
        HLT                    ;Detiene ejecucion del programa
        END                    ;Fin de programa
