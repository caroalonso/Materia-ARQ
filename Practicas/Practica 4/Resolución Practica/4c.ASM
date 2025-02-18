;c) Confeccionar una tabla que compare número de ciclos, CPI, RAWs y Branch Taken Stalls para los dos casos anteriores

       .data
tabla: .word 20, 1, 14, 3, 2, 58, 18, 7, 12, 11
num:   .word 7
long:  .word 10

      .code
       ld r1, long(r0)        # Cargo la longitud de la tabla en r1 (10)
       ld r2, num(r0)         # Cargo el número a buscar en r2 (7)
       dadd r3, r0, r0        # Inicializo r3 en 0 (para recorrer la tabla)
       dadd r10, r0, r0       # Inicializo r10 en 0 (indicador de encontrado)
loop:  ld r4, tabla(r3)       # Cargo en r4 el valor actual de la tabla
       beq r4, r2, listo      # Si r4 == r2, saltar a "listo"
       daddi r1, r1, -1       # Decremento r1 (contador de elementos restantes)
       daddi r3, r3, 8        # Avanzo al siguiente elemento (8 bytes por palabra)
       bnez r1, loop          # Si quedan elementos, repetir loop
       j fin                  # Salto al final
listo: daddi r10, r0, 1       # Indico que se encontró el número
       fin: halt              # Terminar ejecución
