;8) Escribir un programa que multiplique dos números enteros utilizando sumas repetidas (similar al Ejercicio 7 de la Práctica 1).
; El programa debe estar optimizado para su ejecución con la opción Delay Slot habilitada.


.data 
NUM1: .word 5          ; Primer número a multiplicar (5)
NUM2: .word 3          ; Segundo número a multiplicar (3)
RES: .word 0           ; Espacio para guardar el resultado

        .code
        LD R2,NUM2(R0)   ; Cargar el valor de NUM2 (3) en el registro R2
        LD R1,NUM1(R0)   ; Cargar el valor de NUM1 (5) en el registro R1
        BEQZ R2,FIN      ; Si NUM2 (R2) es 0, saltar al final (el resultado es 0)
        DADD R3,R3,R0    ; Inicializar R3 en 0. R3 actuará como acumulador para el resultado de la multiplicación.
SIGO:   BEQZ R1,FIN      ; Si R1 (el contador de iteraciones) llega a 0, saltar al final del programa.
        NOP              ; Instrucción de relleno para llenar el "delay slot" después del salto (J). No afecta la lógica.
        DADD R3,R3,R2    ; Acumular en R3 el valor de R2 (NUM2). Esto realiza una suma repetida, equivalente a multiplicación.
        J SIGO           ; Salta nuevamente a la etiqueta SIGO para continuar el ciclo si R1 no es 0.
        DADDI R1,R1,-1   ; Decrementa el valor de R1 en 1. Esto es parte del ciclo de multiplicación.
FIN:    SD R3,RES(R0)    ; Guardar el valor final de R3 (resultado de la multiplicación) en la dirección de memoria de RES.
        HALT             ; Detener la ejecución del programa.
