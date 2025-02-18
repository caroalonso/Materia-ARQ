; Programa para encender una luz a la vez en el orden especificado

ORG 1000H
PATRON DB 0      ; Variable para almacenar el patrón de luces
FIN DB 0         ; Variable no utilizada, puedes eliminarla si no la necesitas

ORG 3000H
RUT_CLK: 
    PUSH AX          ; Guardamos el valor de AX
    INC PATRON       ; Incrementamos el valor de PATRON (patrón de luces)
    CMP PATRON, 11111111b  ; Comprobamos si el patrón llegó a 11111111b
    JE REINICIAR      ; Si es igual a 11111111b, reiniciar patrón

LUCES: 
    MOV AL, PATRON    ; Cargar el patrón en AL
    OUT 31H, AL       ; Enviar el patrón de luces al puerto 31H
    MOV AL, 0         ; Apagar las luces
    OUT 10H, AL       ; Enviar valor 0 al puerto 10H (apagando luces si es necesario)

    JMP FINAL         ; Salir a la finalización del temporizador

REINICIAR:
    MOV PATRON, 0     ; Reiniciar el patrón de luces
    JMP LUCES         ; Continuar con la actualización de luces

FINAL:
    MOV AL, 20H       ; Fin de la interrupción o temporizador
    OUT 20H, AL       ; Enviar al puerto correspondiente para finalizar
    POP AX            ; Recuperar el valor original de AX
    IRET              ; Retornar de la interrupción

ORG 2000H

; Configuración de los registros del temporizador
MOV AL, 11111111b
OUT 32H, AL           ; Configuración de CA (puerto 32H)
MOV AL, 00000000b
OUT 33H, AL           ; Configuración de CB (puerto 33H)

MOV AX, RUT_CLK       ; Cargar la dirección de la rutina de temporizador en AX
MOV BX, 40            ; Dirección 40H para la tabla de interrupciones (por ejemplo)
MOV [BX], AX          ; Guardamos la dirección de RUT_CLK en la tabla de interrupciones

CLI                   ; Deshabilitar interrupciones
MOV AL, 11111101b     ; Activamos el temporizador
OUT 21H, AL           ; Enviar al puerto 21H (IMR del PIC)

MOV AL, 10            ; Configuración del PIC para el temporizador
OUT 25H, AL           ; Registrar INT1 (Timer) en el PIC
MOV AL, 1             ; Configuración del temporizador para 1 segundo
OUT 11H, AL           ; Enviar valor al registro COMP del temporizador (puerto 11H)
MOV AL, 0
OUT 23H, AL           ; Registro CONT del temporizador (puerto 23H)
OUT 21H, AL           ; Configurar el PIC
OUT 10H, AL           ; Iniciar el temporizador (o apagado de algún registro relacionado)

STI                   ; Habilitar interrupciones
LAZO: JMP LAZO        ; Bucle infinito, esperando interrupciones
END
