;11))Escribir una subrutina que reciba como argumento una tabla de números terminada en 0. La subrutina debe contar la
; cantidad de números que son impares en la tabla, esta condición se debe verificar usando una subrutina es_impar. La
; subrutina es_impar debe devolver 1 si el número es impar y 0 si no lo es

                .data
                tabla:   .word 3, 4, 5, 7, 8, 0   # Ejemplo de tabla de números terminada en 0
                result:  .word 0                  # Resultado de la subrutina (cantidad de impares)

                .code
                la $a0, tabla               # Cargar la dirección de la tabla en $a0
                jal CONTAR_IMPARES          # Llamar a la subrutina para contar impares
                sd $v0, result($zero)       # Guardar el resultado en 'result'
                halt                        # Finalizar ejecución

                # Subrutina CONTAR_IMPARES (contar números impares en la tabla)

CONTAR_IMPARES: dadd $v0, $zero, $zero      # Inicializar el contador de impares en $v0 (0)
                dadd $t0, $a0, $zero        # Copiar la dirección de la tabla en $t0
   loop_contar: lw $t1, 0($t0)              # Cargar el siguiente número de la tabla en $t1
                beqz $t1, fin_contar        # Si es 0 (fin de la tabla), terminar
                move $a0, $t1               # Poner el número actual en $a0 (argumento para es_impar)
                jal es_impar                # Llamar a es_impar
                add $v0, $v0, $v0           # Si es impar, incrementamos el contador
                daddi $t0, $t0, 4           # Avanzar al siguiente número en la tabla (4 bytes)
                j loop_contar               # Continuar con el siguiente número
    fin_contar: jr $ra                      # Retornar a la llamada original

               # Subrutina es_impar (verificar si un número es impar)

      es_impar: andi $t1, $a0, 1            # Realizar una operación AND con 1 (verifica el bit menos significativo)
                beqz $t1, no_es_impar       # Si el resultado es 0, no es impar
                daddi $v0, $zero, 1         # Si es impar, poner 1 en $v0
                jr $ra                      # Retornar
   no_es_impar: daddi $v0, $zero, 0         # Si no es impar, poner 0 en $v0
                jr $ra                      # Retornar
