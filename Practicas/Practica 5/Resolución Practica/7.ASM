;Escriba una subrutina que reciba como parámetros un número positivo M de 64 bits, la dirección del comienzo de una
;tabla que contenga valores numéricos de 64 bits sin signo y la cantidad de valores almacenados en dicha tabla.
;La subrutina debe retornar la cantidad de valores mayores que M contenidos en la tabla.

              .data        
M:            .quad 100                                       # Número M de 64 bits
tabla:        .quad 10, 20, 30, 40, 50, 60, 70, 80, 90, 200   # Tabla con valores
cantidad:     .word 10                                        # Cantidad de valores en la tabla
result:       .word 0                                         # Resultado (cuántos valores son mayores que M)

    .code                            
    ld $a0, M($zero)             # Cargar el valor de M en $a0
    la $a1, tabla                # Cargar la dirección de la tabla en $a1
    lw $a2, cantidad($zero)      # Cargar la cantidad de valores en la tabla en $a2

    jal contar_mayores           # Llamar a la subrutina

    # Almacenar el resultado
    sd $v0, result($zero)        # Guardar el resultado en 'result'
    
    halt # Detener la ejecución

# Subrutina que cuenta los valores mayores que M
contar_mayores:
    # Inicializamos el contador en 0
    daddi $v0, $zero, 0         # $v0 = 0 (contador)

    # Inicializamos el índice en 0
    daddi $t0, $zero, 0         # $t0 = 0 (índice)

loop:
    # Comparar el índice con la cantidad de valores
    bge $t0, $a2, fin           # Si índice >= cantidad, salimos del loop

    # Cargar el valor en la tabla en la dirección $a1 + $t0 * 8
    dadd $t1, $a1, $t0          # $t1 = dirección de tabla + (índice * 8)
    ld $t2, 0($t1)              # $t2 = valor en tabla[$t0]

    # Comparar si el valor en tabla[$t0] > M
    blt $t2, $a0, no_increment  # Si tabla[$t0] <= M, no incrementamos el contador

    # Incrementar el contador
    daddi $v0, $v0, 1           # Incrementamos el contador

no_increment:
    # Incrementar el índice
    daddi $t0, $t0, 1           # Incrementamos el índice

    # Volver al loop
    j loop

fin: jr $ra                      # Regresar de la subrutina
