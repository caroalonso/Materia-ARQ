;10) Escribir un programa que cuente la cantidad de veces que un determinado caracter aparece en una cadena de texto. 
; Observar cómo se almacenan en memoria los códigos ASCII de los caracteres (código de la letra “a” es 61H). 
; Utilizar la instrucción lbu (load byte unsigned) para cargar códigos en registros.
; La inicialización de los datos es la siguiente:
;
; data
; cadena: .asciiz "adbdcdedfdgdhdid" ; cadena a analizar
; car: .asciiz "d" ; caracter buscado
; cant: .word 0 ; cantidad de veces que se repite el caracter car en cadena.

;solucion sin Delay Slot :

.data
cadena: .asciiz "adbdcdedfdgdhdid"  ; Cadena de texto a analizar
car: .asciiz "d"  ; Carácter buscado
cant: .word 0     ; Contador de la cantidad de veces que aparece 'd'

.code
        lbu R1, car(R0)          ; Cargar el carácter a buscar ('d') en R1
        dadd R3, R0, R0          ; Inicializar R3 en 0 (contador de coincidencias)
        dadd R10, R0, R0         ; Inicializar R10 en 0 (puntero a la cadena)
        
SEGUIR: 
        lbu R2, cadena(R10)      ; Cargar el siguiente byte de la cadena
        bne R2, R0, NOCUENTO     ; Si el carácter es 0 (fin de la cadena), termina
        bne R1, R2, NOCUENTO     ; Si R1 (caracter buscado) no es igual a R2 (carácter de la cadena), salta a NOCUENTO

        daddi R3, R3, 1          ; Incrementar el contador si se encuentra una coincidencia
        
NOCUENTO: 
        daddi R10, R10, 1        ; Incrementar el puntero de la cadena
        bne R2, R0, SEGUIR       ; Si el carácter de la cadena no es 0, continuar con el siguiente

        sd R3, cant(R0)          ; Guardar el resultado final (cantidad de coincidencias)
        halt                     ; Finalizar la ejecución

;solucion con Delay Slot:

.data
cadena: .asciiz "adbdcdedfdgdhdid"  ; Cadena de texto a analizar
car: .asciiz "d"  ; Carácter buscado
cant: .word 0     ; Contador de la cantidad de veces que aparece 'd'

.code
        lbu R1, car(R0)          ; Cargar el carácter a buscar ('d') en R1
        dadd R3, R0, R0          ; Inicializar R3 en 0 (contador de coincidencias)
        dadd R10, R0, R0         ; Inicializar R10 en 0 (puntero a la cadena)
        
SEGUIR: 
        lbu R2, cadena(R10)      ; Cargar el siguiente byte de la cadena
        bne R2, R0, NOCUENTO     ; Si el carácter es 0 (fin de la cadena), termina (delay slot aprovechado aquí)
        nop                      ; Instrucción de *nop* para llenar el delay slot
        bne R1, R2, NOCUENTO     ; Si R1 (caracter buscado) no es igual a R2 (carácter de la cadena), salta a NOCUENTO
        nop                      ; Instrucción de *nop* para llenar el delay slot

        daddi R3, R3, 1          ; Incrementar el contador si se encuentra una coincidencia
        
NOCUENTO: 
        daddi R10, R10, 1        ; Incrementar el puntero de la cadena
        bne R2, R0, SEGUIR       ; Si el carácter de la cadena no es 0, continuar con el siguiente

        sd R3, cant(R0)          ; Guardar el resultado final (cantidad de coincidencias)
        halt                     ; Finalizar la ejecución
