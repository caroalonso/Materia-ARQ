;      data
;      A: .word 1
;      B: .word 6
;     .code
;      ld r1, A(r0)
;      ld r2, B(r0)
;loop: dsll r1, r1, 1
;      daddi r2, r2, -1
;      bnez r2, loop
;      halt

; c) Reordenar las instrucciones para que la cantidad de RAW sea ‘0’ en la ejecución del programa (Forwarding habilitado):

      .data
      A: .word 1
      B: .word 6
      .code
      ld r2, B(r0)       # Cargar B en r2
      ld r1, A(r0)       # Cargar A en r1 (mueve su uso más lejos)
      daddi r2, r2, -1   # No depende de r1, así que se ejecuta primero
loop: dsll r1, r1, 1     # Ahora r1 ya está listo
      bnez r2, loop      # Verifica si r2 es distinto de 0
      halt
