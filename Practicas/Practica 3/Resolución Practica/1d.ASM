; Programa para encender y apagar luces sincronizadamente con contador

ORG 0x00    ; Dirección de inicio del programa

START:
    MOV PIOA, 0xFF    ; Configurar todos los pines del puerto A como entrada (llaves)
    MOV PIOB, 0x00    ; Inicializar las luces en apagado

    MOV R0, 0x00      ; Inicializar contador en 0

LOOP:
    ; Incrementar el contador (1 incremento por ciclo)
    INC R0
    MOV A, R0         ; Mover el contador a A
    MOV PIOB, A       ; Actualizar las luces con el valor del contador

    ; Verificar si el contador llegó a 11111111 (0xFF)
    CMP A, 0xFF
    JE END_PROGRAM    ; Si el contador es igual a 0xFF, salir del programa

    NOP               ; No hacer nada (espera o proceso de descanso)
    JMP LOOP          ; Continuar con el ciclo

END_PROGRAM:
    NOP               ; Fin del programa
