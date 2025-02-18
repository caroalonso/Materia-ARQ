;10)
          .data 
letra:    .ascii 'O'             # Ejemplo de letra para es_vocal
vocales:  .asciiz 'AEIOUaeiou'   # Vocales que se consideran
result:   .word 0                # Resultado de la subrutina es_vocal
cadena:   .asciiz "Hola Mundo"   # Ejemplo de cadena a contar

         .code 
          la $a0, cadena            # Cargar la dirección de la cadena
          jal CONTAR_VOC            # Llamar a la subrutina para contar vocales
          sd $v0, result($zero)     # Guardar el resultado en 'result'
          halt                      # Finalizar ejecución

# Subrutina CONTAR_VOC (contar vocales en la cadena)

CONTAR_VOC: dadd $v0, $zero, $zero     # Inicializar contador de vocales en $v0
            dadd $t0, $a0, $zero       # Copiar la dirección de la cadena en $t0
     loop:  lbu $t1, 0($t0)            # Cargar el siguiente byte de la cadena en $t1
            beqz $t1, fin_contar       # Si es el fin de la cadena (\0), terminar
            move $a0, $t1              # Poner el carácter actual en $a0 (argumento para es_vocal)
            jal es_vocal               # Llamar a es_vocal
            add $v0, $v0, $v0          # Si es vocal, incrementamos el contador
            daddi $t0, $t0, 1          # Avanzar al siguiente carácter de la cadena
            j loop                     # Repetir el ciclo
fin_contar: jr $ra                     # Retornar a la llamada original

# Subrutina es_vocal (verificar si un carácter es vocal)

    es_vocal: dadd $v0, $0, $0          # Inicializar $v0 en 0 (resultado de si es vocal)
              daddi $t0, $0, 0          # Inicializar el índice para la cadena de vocales
loop_esvocal: lbu $t1, vocales($t0)     # Cargar el siguiente carácter de la cadena vocales
              beqz $t1, fin_esvocal     # Si llegamos al final de las vocales, terminar
              beq $a0, $t1, si_es_voc   # Si el carácter actual es igual a una vocal, marcarlo como vocal
              daddi $t0, $t0, 1         # Avanzar al siguiente carácter en vocales
              j loop_esvocal            # Continuar buscando
  si_es_voc: daddi $v0, $0, 1           # Si encontramos una vocal, poner 1 en $v0
fin_esvocal: jr $ra                     # Retornar a la función que hizo la llamada
