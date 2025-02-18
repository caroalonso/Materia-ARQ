;15) Escribir un programa que implemente un conteo regresivo a partir de un valor ingresado desde el teclado. El conteo
; debe comenzar al presionarse la tecla F10. El tiempo transcurrido debe mostrarse en pantalla, actualizándose el valor cada
; segundo.

TIMER   EQU     10H
PIC     EQU     20H
EOI     EQU     20H
N_CLK   EQU     10      ; Número de interrupciones por segundo
F10     EQU     8       ; Número de la interrupción para la tecla F10

ORG 40
IP_CLK  DW      RUT_CLK    ; Dirección de la rutina de interrupción del reloj
IP_F10  DW      RUT_F10    ; Dirección de la rutina de interrupción F10

ORG 1000H
VALOR   DB      ?         ; Variable para almacenar el valor del conteo
SEG     DB      00H       ; Variable para mostrar el tiempo transcurrido
FIN     DB      ?

ORG 3000H
RUT_F10:
    PUSH AX
    MOV AL, [VALOR]      ; Leer el valor inicial del conteo
    CMP AL, 00H          ; Si el valor es 0, no hace nada
    JE FIN_F10
    MOV AL, 01H          ; Cambiar el estado a "en marcha"
    MOV [START], AL      ; Guardar el estado de inicio
    JMP FIN_F10
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
    DEC [VALOR]          ; Decrementar el valor del conteo
    MOV AL, [VALOR]
    CMP AL, 00H          ; Verificar si se alcanzó 0
    JE DETENER_CONTADOR  ; Si llegó a 0, detener el contador
    ; Aquí es donde actualizamos la pantalla con el valor restante
    ; El código exacto para mostrar el valor depende del sistema utilizado
    ; Por ejemplo, podríamos llamar a un servicio de visualización
    JMP LAZO             ; Continuar contando

DETENER_CONTADOR:
    MOV [START], 00H     ; Detener el reloj
    MOV AL, EOI
    OUT PIC, AL          ; Señalar el final de la interrupción
    JMP LAZO             ; Volver al bucle principal
END
