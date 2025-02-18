; 7)Escribir un programa que recorra una TABLA de diez números enteros y determine cuántos elementos son mayores que X. 
; El resultado debe almacenarse en una dirección etiquetada CANT. 
; El programa debe generar además otro arreglo llamado RES cuyos elementos sean ceros y unos. 
; Un ‘1’ indicará que el entero correspondiente en el arreglo TABLA es mayor que X, mientras que un ‘0’ indicará que es menor o igual.

            .data
    Tabla: .word 1,4,5,6,6,8,2,2,9,10      ; La tabla con los valores
    Res:   .word 0,0,0,0,0,0,0,0,0,0       ; El arreglo de resultados
    X:     .word 4                         ; El valor de referencia X
    Long:  .word 10                        ; El número de elementos en la tabla
    Cant:  .word 0                         ; El contador de elementos mayores o iguales a X

         .code
          LD R1, Long(R0)          ; Cargar en R1 la longitud de la tabla (10)
          LD R2, X(R0)             ; Cargar en R2 el valor de X (4)
          DADD R3, R0, R0          ; Inicializar R3 a 0, usado para recorrer la tabla
          DADD R5, R0, R0          ; Inicializar R5 a 0, para contar los valores mayores o iguales a X
          DADDI R8, R0, 1          ; Inicializar R8 a 1, el valor que se almacenará en Res cuando el valor sea mayor o igual a X
    SIGO: LD R4, Tabla(R3)         ; Cargar en R4 el valor de la tabla en la posición actual
          SLT R6, R4, R2           ; R6 = 1 si R4 < X, 0 si R4 >= X
          BNEZ R6, ES_MENOR        ; Si R6 != 0 (R4 < X), saltar a ES_MENOR
          DSUB R7, R4, R2          ; R7 = R4 - X (el valor de la tabla menos X)
          BEQZ R7, ES_MENOR        ; Si R7 == 0 (R4 == X), saltar a ES_MENOR
          SD R8, Res(R3)           ; Almacenar 1 en Res, ya que R4 >= X
          DADDI R5, R5, 1          ; Incrementar el contador de elementos mayores o iguales a X
ES_MENOR: DADDI R3, R3, 8          ; Mover al siguiente elemento en la tabla 
          DADDI R1, R1, -1         ; Decrementar el contador de elementos restantes
          BNEZ R1, SIGO            ; Si no hemos recorrido todos los elementos, continuar en el ciclo
          SD R5, Cant(R0)          ; Almacenar la cantidad de elementos mayores o iguales a X en Cant
          HALT                     ; Terminar la ejecución
