; Programa para encender y apagar luces mediante las llaves

ORG 0x00    ; Dirección de inicio del programa

START:
    MOV PIOA, 0xFF    ; Configurar todos los pines del puerto A como entrada (llaves)
    
LOOP:
    MOV A, PIOA       ; Leer el valor de las llaves desde el puerto A
    MOV PIOB, A       ; Actualizar el estado de las luces (puerto B)
    NOP               ; No hacer nada (espera o proceso de descanso)
    JMP LOOP          ; Continuar el ciclo indefinidamente
