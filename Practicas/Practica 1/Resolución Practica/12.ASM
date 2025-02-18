;12)Usando la subrutina anterior escribir la subrutina VOCALES, que recibe una cadena por referencia, y devuelve, en
; un registro, la cantidad de vocales que tiene esa cadena


ORG 1000H
FRASE     DB   "ABBEuMMno", 0   ; Cadena de ejemplo, terminada con 0 (nulo)

ORG 3000H
; Subrutina que verifica si un carácter es vocal (mayúsculas o minúsculas)
ES_VOCAL:
    CMP  AL, 41H   ; Compara con 'A' (41H)
    JZ   FIN       ; Si es igual a 'A', salta a FIN
    CMP  AL, 45H   ; Compara con 'E' (45H)
    JZ   FIN       ; Si es igual a 'E', salta a FIN
    CMP  AL, 49H   ; Compara con 'I' (49H)
    JZ   FIN       ; Si es igual a 'I', salta a FIN
    CMP  AL, 4EH   ; Compara con 'O' (4EH)
    JZ   FIN       ; Si es igual a 'O', salta a FIN
    CMP  AL, 55H   ; Compara con 'U' (55H)
    JZ   FIN       ; Si es igual a 'U', salta a FIN
    CMP  AL, 61H   ; Compara con 'a' (61H)
    JZ   FIN       ; Si es igual a 'a', salta a FIN
    CMP  AL, 65H   ; Compara con 'e' (65H)
    JZ   FIN       ; Si es igual a 'e', salta a FIN
    CMP  AL, 69H   ; Compara con 'i' (69H)
    JZ   FIN       ; Si es igual a 'i', salta a FIN
    CMP  AL, 6FH   ; Compara con 'o' (6FH)
    JZ   FIN       ; Si es igual a 'o', salta a FIN
    CMP  AL, 75H   ; Compara con 'u' (75H)
    JZ   FIN       ; Si es igual a 'u', salta a FIN
    MOV  AL, 00H   ; Si no es una vocal, poner AL a 0
    JMP  FINAL     ; Salta a la sección final

FIN:
    MOV  AL, 0FFH  ; Si es vocal, poner AL a 0FFH

FINAL:
    RET             ; Regresa de la subrutina

ORG 4000H
; Subrutina que recorre la cadena y cuenta las vocales
VOCALES:
    CMP  BYTE PTR [BX], 0   ; Si el caracter es nulo (fin de cadena), terminar
    JZ   FIN1               ; Si llegamos al final de la cadena, saltamos a FIN1
    MOV  AL, [BX]           ; Cargar el carácter en AL
    CALL ES_VOCAL           ; Llamar a ES_VOCAL para verificar si es vocal
    CMP  AL, 0              ; Si no es vocal (AL=0), no hacer nada
    JZ   NO_ES_VOC          ; Si no es vocal, saltamos a NO_ES_VOC
    INC  CX                 ; Si es vocal, incrementar el contador de vocales (CX)

NO_ES_VOC:
    INC  BX                 ; Avanzar al siguiente carácter en la cadena
    JMP  VOCALES            ; Repetir para el siguiente carácter

FIN1:
    RET                     ; Finalizar la subrutina

ORG 2000H
    MOV  BX, OFFSET FRASE   ; Poner la dirección de la cadena en BX
    MOV  CX, 0              ; Inicializar el contador de vocales en CX
    CALL VOCALES            ; Llamar a la subrutina VOCALES para contar las vocales
    HLT                     ; Finalizar el programa

END
