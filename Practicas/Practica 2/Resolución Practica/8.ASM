;8) Escribir un programa que efectúe la resta de dos números (de un dígito cada uno) ingresados por teclado y muestre el
; resultado en la pantalla de comandos. Antes de visualizarlo el programa debe verificar si el resultado es positivo o negativo
; y anteponer al valor el signo correspondiente.

            ORG  1000H
MSJ1        DB  "INGRESE PRIMER NUMERO"
FIN1        DB  ?
MSJ2        DB  "INGRESE SEGUNDO NUMERO"
FIN2        DB  ?
NUM1        DB  ?
NUM2        DB  ?
RESUL       DB  ?
            DB  ?

            ORG 2000H
            MOV AX, 0000H
            ; Mostrar mensaje "INGRESE PRIMER NUMERO"
            MOV BX, OFFSET MSJ1
            MOV AL, OFFSET FIN1 - OFFSET MSJ1
            INT 7
            ; Leer primer número
            MOV BX, OFFSET NUM1
            INT 6
            ; Mostrar mensaje "INGRESE SEGUNDO NUMERO"
            MOV BX, OFFSET MSJ2
            MOV AL, OFFSET FIN2 - OFFSET MSJ2
            INT 7
            ; Leer segundo número
            MOV BX, OFFSET NUM2
            INT 6
            ; Realizar la resta
            MOV AL, NUM1
            SUB AL, NUM2
            ; Verificar si el resultado es negativo
            JS ES_NEGATIVO  ; Salta si el resultado es negativo
            ; Si es positivo, convertir a ASCII y agregar '+'
            ADD AL, 30H
            MOV AH, 2BH    ; Código ASCII para '+'
            JMP MOSTRAR_RESULTADO
ES_NEGATIVO:
            ; Calcular complemento a dos para obtener el valor absoluto
            NEG AL  ; AL = -AL
            ADD AL, 30H
            MOV AH, 2DH    ; Código ASCII para '-'

MOSTRAR_RESULTADO:
            MOV RESUL, AH
            MOV RESUL+1, AL
            ; Mostrar resultado
            MOV BX, OFFSET RESUL
            MOV AL, 2
            INT 7
            HLT
            END
