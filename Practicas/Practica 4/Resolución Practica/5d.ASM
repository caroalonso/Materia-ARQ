;d) Modificar el programa para aprovechar el ‘Delay Slot’ ejecutando una instrucción útil. 
; Simular y comparar número de ciclos, instrucciones y CPI obtenidos con los de la versión anterior

.data
cant: .word 8
datos: .word 1, 2, 3, 4, 5, 6, 7, 8
res: .word 0

.code
      dadd r1, r0, r0    ; inicializa r1=0
      ld r2, cant(r0)    ; mueve a r2=8 cantidad de elementos que tiene el vector
loop: ld r3, datos(r1)   ; mueve a r3 los valores del vector
      daddi r2, r2, -1   ; disminuye en uno la cantidad de elementos del vector
      dsll r3, r3, 1     ; multiplica el elemento del vector y lo guarda en r3
      sd r3, res(r1)     ; guarda el resultado en res
      daddi r1, r1, 8    ; se corre al siguiente elemento del vector
      bnez r2, loop      ; mientras no termine la tabla salta
      halt
