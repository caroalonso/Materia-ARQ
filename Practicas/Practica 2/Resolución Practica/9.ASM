; 9) Escribir un programa que aguarde el ingreso de una clave de cuatro caracteres por teclado sin visualizarla en pantalla.
; En caso de coincidir con una clave predefinida (y guardada en memoria) que muestre el mensaje "Acceso permitido", caso
; contrario el mensaje "Acceso denegado".

        ORG 1000H
MSJ     DB "INGRESE CLAVE"
FIN     DB ?
CLAVE   DB "casi"         ; Clave predefinida
ING     DB ?              ; Espacio para almacenar la clave ingresada
        DB ?
        DB ?
        DB ?
CAR1    DB "ACCESO PERMITIDO"
FIN1    DB ?
CAR2    DB "ACCESO DENEGADO"
FIN2    DB ?


        ORG 2000H
        MOV BX, OFFSET MSJ
        MOV AL, OFFSET FIN - OFFSET MSJ
        INT 7           ; Mostrar mensaje "INGRESE CLAVE"
        ; Leer 4 caracteres sin mostrarlos
        MOV CL, 4
        MOV BX, OFFSET ING
READ:   INT 6
        INC BX
        DEC CL
        JNZ READ
        ; Comparar la clave ingresada con la clave predefinida
        MOV DX, OFFSET ING
        MOV CX, OFFSET CLAVE
        MOV CL, 4       ; Comparar los 4 caracteres
COMPARE:
        MOV AL, [CX]    ; Leer caracter de la clave original
        MOV BL, [DX]    ; Leer caracter ingresado
        CMP AL, BL
        JNZ ACCDEN      ; Si no coinciden, saltar a "Acceso denegado"
        INC DX          ; Avanzar al siguiente caracter
        INC CX
        DEC CL
        JNZ COMPARE     ; Si aún quedan caracteres, seguir comparando
        ; Si la clave es correcta, mostrar "ACCESO PERMITIDO"
        MOV BX, OFFSET CAR1
        MOV AL, OFFSET FIN1 - OFFSET CAR1
        INT 7
        JMP FINAL
ACCDEN: ; Si la clave es incorrecta, mostrar "ACCESO DENEGADO"
        MOV BX, OFFSET CAR2
        MOV AL, OFFSET FIN2 - OFFSET CAR2
        INT 7
FINAL:  INT 0           ; Terminar el programa
        END

