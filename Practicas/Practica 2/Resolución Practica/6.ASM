;6) Escribir un programa que solicite el ingreso de un número (de un dígito) por teclado y muestre en pantalla dicho
; número expresado en letras. Luego que solicite el ingreso de otro y así sucesivamente. Se debe finalizar la ejecución al
; ingresarse en dos vueltas consecutivas el número cero. 

        ORG 1000H
MSJ     DB "INGRESE UN NUMERO", 0
NUM     DB ?  
PREV    DB 0   ; Variable para almacenar el número anterior
CERO0   DB "CERO", 0
UNO1    DB "UNO", 0
DOS2    DB "DOS", 0
TRES3   DB "TRES", 0
CUATRO4 DB "CUATRO", 0
CINCO5  DB "CINCO", 0
SEIS6   DB "SEIS", 0
SIETE7  DB "SIETE", 0
OCHO8   DB "OCHO", 0
NUEVE9  DB "NUEVE", 0

        ORG 2000H
START:  
        MOV BX, OFFSET MSJ
        MOV AL, LENGTHOF MSJ
        INT 7   ; Mostrar mensaje "INGRESE UN NÚMERO"

        MOV BX, OFFSET NUM
        INT 6   ; Leer número

        MOV AL, [NUM]  ; Obtener el número ingresado
        CMP AL, 30H    ; Comparar con '0'
        JNZ NO_CERO

        ; Si el número ingresado es 0, verificar el anterior
        CMP [PREV], 30H
        JZ FIN          ; Si el anterior también era 0, salir

        MOV [PREV], 30H ; Guardar el 0 como número anterior
        JMP PRINT_NUM

NO_CERO:
        MOV [PREV], AL  ; Guardar número ingresado como anterior

PRINT_NUM:
        ; Comparar el número ingresado con los valores del 0 al 9
        CMP AL, 31H
        JZ PRINT_UNO
        CMP AL, 32H
        JZ PRINT_DOS
        CMP AL, 33H
        JZ PRINT_TRES
        CMP AL, 34H
        JZ PRINT_CUATRO
        CMP AL, 35H
        JZ PRINT_CINCO
        CMP AL, 36H
        JZ PRINT_SEIS
        CMP AL, 37H
        JZ PRINT_SIETE
        CMP AL, 38H
        JZ PRINT_OCHO
        CMP AL, 39H
        JZ PRINT_NUEVE
PRINT_CERO:
        MOV BX, OFFSET CERO0
        MOV AL, LENGTHOF CERO0
        INT 7
        JMP START
PRINT_UNO:
        MOV BX, OFFSET UNO1
        MOV AL, LENGTHOF UNO1
        INT 7
        JMP START
PRINT_DOS:
        MOV BX, OFFSET DOS2
        MOV AL, LENGTHOF DOS2
        INT 7
        JMP START
PRINT_TRES:
        MOV BX, OFFSET TRES3
        MOV AL, LENGTHOF TRES3
        INT 7
        JMP START
PRINT_CUATRO:
        MOV BX, OFFSET CUATRO4
        MOV AL, LENGTHOF CUATRO4
        INT 7
        JMP START
PRINT_CINCO:
        MOV BX, OFFSET CINCO5
        MOV AL, LENGTHOF CINCO5
        INT 7
        JMP START
PRINT_SEIS:
        MOV BX, OFFSET SEIS6
        MOV AL, LENGTHOF SEIS6
        INT 7
        JMP START
PRINT_SIETE:
        MOV BX, OFFSET SIETE7
        MOV AL, LENGTHOF SIETE7
        INT 7
        JMP START
PRINT_OCHO:
        MOV BX, OFFSET OCHO8
        MOV AL, LENGTHOF OCHO8
        INT 7
        JMP START
PRINT_NUEVE:
        MOV BX, OFFSET NUEVE9
        MOV AL, LENGTHOF NUEVE9
        INT 7
        JMP START
FIN:
        HLT
        END
