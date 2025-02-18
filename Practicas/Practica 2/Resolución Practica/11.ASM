;11) Escribir un programa que permita seleccionar una letra del abecedario al azar. El código de la letra debe generarse en
; un registro que incremente su valor desde el código de A hasta el de Z continuamente. La letra debe quedar seleccionada al
; presionarse la tecla F10 y debe mostrarse de inmediato en la pantalla de comandos


EOI        EQU   20H
PIC        EQU   20H
IMR        EQU   21H
INT0       EQU   24H
N_F10      EQU   8   ; Número de interrupción para F10

ORG 1000H
MOSTRAR    DB    "A" ; Para mostrar la letra seleccionada

ORG 32
DW   INT_F10           ; Manejador de la interrupción F10

ORG 3000H
INT_F10:
    PUSH AX              ; Guardamos el valor de AX
    INC MOSTRAR          ; Incrementamos la letra
    CMP MOSTRAR, 5AH     ; Comprobamos si es mayor que 'Z'
    JG  REINICIAR        ; Si es mayor que 'Z', reiniciamos
    MOV DL, MOSTRAR      ; Colocamos la letra en DL para mostrarla
    ADD DL, 30H          ; Convertimos el valor ASCII en un carácter
    MOV AH, 2            ; Función para mostrar un carácter
    INT 21H              ; Llamada a la interrupción DOS para mostrar el carácter
    MOV AL, EOI          ; Enviamos la señal de fin de interrupción
    OUT EOI, AL          ; Finalizamos la interrupción
    POP AX               ; Restauramos AX
    IRET                 ; Retornamos de la interrupción

REINICIAR:
    MOV MOSTRAR, 41H     ; Reiniciamos la letra a 'A'
    JMP SIGO             ; Volvemos al ciclo

ORG 2000H
CLI                      ; Deshabilitamos interrupciones
MOV AL, 0FEH             ; Permitimos interrupciones de F10
OUT IMR, AL              ; Activamos el bit de interrupciones
MOV AL, N_F10            ; Número de interrupción para F10
OUT INT0, AL             ; Establecemos la interrupción para F10
MOV BX, OFFSET MOSTRAR   ; Inicializamos el valor de la letra
MOV AL, 1                ; Inicializamos el valor de AH a 1
STI                      ; Habilitamos interrupciones

SIGO:
    JMP SIGO             ; Lazo infinito para mantener el programa en ejecución

HLT                      ; Finalizamos el programa
END
