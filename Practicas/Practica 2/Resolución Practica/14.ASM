;Implementar un reloj similar al utilizado en los partidos de básquet, que arranque y detenga su marcha al presionar
;sucesivas veces la tecla F10 y que finalice el conteo al alcanzar los 30 segundos. 

TIMER   EQU     10H
PIC     EQU     20H
EOI     EQU     20H
N_CLK   EQU     10      ; Número de interrupciones por segundo
F10     EQU     8       ; Número de la interrupción para la tecla F10

ORG 40
IP_CLK  DW      RUT_CLK    ; Dirección de la rutina de interrupción del reloj
IP_F10  DW      RUT_F10    ; Dirección de la rutina de interrupción F10

ORG 1000H
SEG     DB      30H       ; Segundos
        DB      30H
START   DB      00H       ; Estado del reloj (0: detenido, 1: en marcha)
FIN     DB      ?


ORG 3000H
RUT_F10:
    PUSH AX
    MOV AL, [START]      ; Leer el estado actual del reloj
    CMP AL, 01H          ; Si está en marcha (1), detenerlo; si está detenido (0), iniciarlo
    JE DETENER           ; Si está en marcha, ir a detener
    MOV AL, 01H          ; Cambiar el estado a "en marcha"
    MOV [START], AL      ; Guardar el nuevo estado
    JMP FIN_F10
DETENER:
    MOV AL, 00H          ; Cambiar el estado a "detenido"
    MOV [START], AL      ; Guardar el nuevo estado
FIN_F10:
    MOV AL, EOI
    OUT PIC, AL          ; Señalar el final de la interrupción
    POP AX
    IRET


ORG 2000H
CLI
MOV AL, 0FDH
OUT PIC+1, AL          ; PIC: registro IMR (habilitar interrupciones)
MOV AL, N_CLK
OUT PIC+5, AL          ; PIC: registro INT1 (habilitar interrupción por TIMER)
MOV AL, 1
OUT TIMER+1, AL        ; TIMER: registro COMP (configurar el temporizador)
MOV AL, 0
OUT TIMER, AL          ; TIMER: registro CONT (iniciar el temporizador)
MOV BX, OFFSET SEG
MOV AL, OFFSET FIN - OFFSET SEG
STI
LAZO:
    CMP [START], 01H     ; Si el reloj está en marcha (1)
    JE CONTAR_SEGUNDOS   ; Ir a contar los segundos
    JMP LAZO             ; Si está detenido, seguir en el bucle principal
CONTAR_SEGUNDOS:
    INC SEG+1            ; Incrementar los segundos
    CMP SEG+1, 3AH       ; Verificar si los segundos llegaron a 60 (3AH en hexadecimal)
    JNZ CONTINUAR        ; Si no es así, continuar
    MOV SEG+1, 30H       ; Reiniciar los segundos
    INC SEG              ; Incrementar los minutos
    CMP SEG, 36H         ; Verificar si los minutos llegaron a 60 (36H en hexadecimal)
    JNZ CONTINUAR        ; Si no es así, continuar
    MOV SEG, 30H         ; Reiniciar los minutos
CONTINUAR:
    CMP SEG, 1EH         ; Si el reloj llegó a 30 segundos (1EH en hexadecimal)
    JE DETENER_CONTADOR  ; Detener el reloj si llegó a 30 segundos
    JMP LAZO             ; Continuar contando los segundos
DETENER_CONTADOR:
    MOV [START], 00H     ; Detener el reloj
    MOV SEG, 30H         ; Resetear los segundos
    MOV SEG+1, 30H
    MOV AL, EOI
    OUT PIC, AL          ; Señalar el final de la interrupción
    JMP LAZO             ; Volver al bucle principal
END
