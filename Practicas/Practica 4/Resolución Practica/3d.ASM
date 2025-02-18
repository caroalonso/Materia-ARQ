;d) Modificar el programa para que almacene en un arreglo en memoria de datos los contenidos 
; parciales del registro r1 ¿Qué significado tienen los elementos de la tabla que se genera?

      .data
      A: .word 1
      B: .word 6
      ARREGLO: .word 0:6  # Reservo espacio para los 6 valores de la tabla

      .code
      ld r1, A(r0)         # Cargo el valor 1 en r1
      ld r2, B(r0)         # Cargo el valor 6 en r2
      dadd r4, r0, r0      # Inicializo r4 en 0 para moverme en el arreglo
      sw r1, ARREGLO(r4)   # Almaceno el primer valor en el arreglo
loop: dsll r1, r1, 1       # Desplazo r1 a la izquierda (multiplico por 2)
      daddi r4, r4, 4      # Me muevo en el arreglo (4 bytes por palabra)
      sw r1, ARREGLO(r4)   # Almaceno el nuevo valor en el arreglo
      daddi r2, r2, -1     # Decremento r2
      bnez r2, loop        # Repito mientras r2 no sea 0
      halt


;Explicación del significado de la tabla:
;Cada elemento almacenado en ARREGLO es una potencia de 2:

;Iteración	  Valor de r1	Valor    almacenado en ARREGLO
; 0	           1	                  1
; 1	           2	                  2
; 2	           4                  	4
; 3	           8	                  8
; 4	           16                 	16
; 5	           32	                  32

;El contenido de ARREGLO almacena los valores de r1 en cada iteración del bucle. Cada valor es el doble del anterior, 
;generando la secuencia de potencias de 2.
;Si quisieras almacenar doublewords (.dword en vez de .word), podrías seguir usando sd y aumentar r4 de a 8.