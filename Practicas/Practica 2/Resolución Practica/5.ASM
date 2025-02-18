  ; Modificar el programa anterior agregando una subrutina llamada ES_NUM que 
  ; verifique si el caracter ingresado es realmente un número. 
  ; De no serlo, el programa debe mostrar el mensaje “CARACTER NO VALIDO”. 
  ; La subrutina debe recibir el código del caracter por referencia desde el programa principal
  ; y debe devolver vía registro el valor 0FFH en caso de tratarse de un número o el valor 00H en caso contrario. 
  ; Tener en cuenta que el código del “0” es 30H y el del “9” es 39H
  
  
            ORG 1000H
NUM        DB  ?          ; Variable para almacenar el caracter ingresado
MSJ1       DB  "CARACTER NO VALIDO", 0
MSJ2       DB  "CARACTER VALIDO", 0

            ORG 3000H
ES_NUM:    MOV AH, [BX]   ; Cargar el caracter desde la dirección en BX
           CMP AH, '0'    ; Comparar con el carácter '0' (30H)
           JL  NO_ES      ; Si es menor, no es un número
           CMP AH, '9'    ; Comparar con el carácter '9' (39H)
           JG  NO_ES      ; Si es mayor, no es un número
           MOV AH, 0FFH   ; Es un número, devolver 0FFH
           RET

NO_ES:     MOV AH, 00H    ; No es un número, devolver 00H
           RET

            ORG 2000H
           MOV BX, OFFSET NUM  ; Dirección de la variable NUM
           INT 6               ; Leer un caracter desde el teclado y almacenarlo en NUM
           CALL ES_NUM         ; Llamar a la subrutina para verificar si es número
           CMP AH, 00H         ; ¿Es número?
           JZ NO_ES_NUM        ; Si AH == 00H, no es número, ir a NO_ES_NUM

           ; Si es un número, mostrar "CARACTER VALIDO"
           MOV BX, OFFSET MSJ2
           INT 7
           JMP FIN

NO_ES_NUM: ; Si no es un número, mostrar "CARACTER NO VALIDO"
           MOV BX, OFFSET MSJ1
           INT 7
FIN:       HLT   ; Terminar el programa
           END
