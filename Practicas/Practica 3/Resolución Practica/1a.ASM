; Programa para encender luces con patrón 11000011

ORG 0x00    ; Dirección de inicio del programa

START:
    MOV PIOA, 0xFF    ; Configurar todos los pines del puerto A como entrada (llaves)
    MOV PIOB, 0xC3    ; Configurar las luces con el patrón 11000011
    NOP               ; No hacer nada (espera o proceso de descanso)
    JMP START         ; Repetir continuamente
