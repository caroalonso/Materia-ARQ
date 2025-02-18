; Programa para verificar si la llave de más a la izquierda está prendida

ORG 0x00    ; Dirección de inicio del programa

START:
    MOV PIOA, 0xFF    ; Configurar todos los pines del puerto A como entrada (llaves)
    MOV A, PIOA       ; Leer el valor del puerto A (estado de las llaves)
    ; Verificar el bit más significativo (MSB)
    ANL A, 0x80       ; Realizar una máscara para obtener el MSB (bit más significativo)
    JZ KEY_OFF        ; Si el MSB es 0, la llave está apagada

KEY_ON:
    ; Mostrar "Llave prendida" en pantalla (esto depende del simulador y cómo se gestiona la pantalla)
    MOV A, "Llave prendida"
    JMP START         ; Continuar verificando

KEY_OFF:
    ; Mostrar "Llave apagada" en pantalla
    MOV A, "Llave apagada"
    JMP START         ; Continuar verificando
