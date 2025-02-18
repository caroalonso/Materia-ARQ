;Modificar el programa anterior para que también cuente minutos (00:00 - 59:59), pero que actualice la visualización en
;pantalla cada 10 segundos.

TIMER   EQU     10H
PIC     EQU     20H
EOI     EQU     20H
N_CLK   EQU     10

ORG 40
IP_CLK  DW      RUT_CLK

ORG 1000H
MIN     DB      30H    ; Minutos
        DB      30H    ; Minutos
        DB      ":"    ; Separador ":"
SEG     DB      30H    ; Segundos
        DB      30H    ; Segundos
FIN     DB      ?

ORG 3000H
RUT_CLK: 
    PUSH AX

    ; Incrementar los segundos
    INC SEG+1
    CMP SEG+1, 3AH       ; Comprobar si los segundos llegaron a 60 (3AH en hexadecimal)
    JNZ RESET1

    MOV SEG+1, 30H       ; Reiniciar los segundos
    INC SEG              ; Incrementar el valor de los minutos
    CMP SEG, 36H         ; Comprobar si los minutos llegaron a 60 (36H en hexadecimal)
    JNZ RESET            ; Si no es así, continuar

    MOV SEG, 30H         ; Reiniciar los minutos
    INC MIN+1            ; Incrementar los minutos
    CMP MIN+1, 3AH       ; Verificar si los minutos llegaron a 60 (3AH en hexadecimal)
    JNZ RESET1
    MOV MIN+1, 30H       ; Reiniciar minutos de decena
    INC MIN              ; Incrementar la decena de minutos
    CMP MIN, 36H         ; Verificar si los minutos llegaron a 60
    JNZ RESET1
    MOV MIN, 30H         ; Reiniciar minutos de decena

RESET1:
    INT 7                 ; Terminar la interrupción
    MOV AL, 0
    OUT TIMER, AL        ; Reiniciar el temporizador
    MOV AL, EOI
    OUT PIC, AL          ; Señalar el fin de la interrupción
    POP AX
    IRET

RESET:
    ; Resetear después de 60 segundos o 60 minutos
    MOV SEG, 30H
    MOV SEG+1, 30H
    MOV MIN, 30H
    MOV MIN+1, 30H
    ; Volver a iniciar el ciclo de interrupción
    INT 7

ORG 2000H
CLI
MOV AL, 0FDH
OUT PIC+1, AL         ; PIC: registro IMR (habilitar interrupciones)
MOV AL, N_CLK
OUT PIC+5, AL         ; PIC: registro INT1 (habilitar interrupción por TIMER)
MOV AL, 1
OUT TIMER+1, AL       ; TIMER: registro COMP (configurar el contador del temporizador)
MOV AL, 0
OUT TIMER, AL         ; TIMER: registro CONT (iniciar el contador)
MOV BX, OFFSET MIN
MOV AL, OFFSET FIN - OFFSET MIN
STI

LAZO:
    JMP LAZO            ; Bucle principal para mantener el programa corriendo

END

