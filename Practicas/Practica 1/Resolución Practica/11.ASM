;Escriba la subrutina ES_VOCAL, que determina si un caracter es vocal o no. La rutina debe recibir el caracter por
;valor, y debe retornar, vía registro, el valor 0FFH si el caracter es una vocal, o 00H en caso contrario.

ORG 3000H
ES_VOCAL:
    CMP AL, 'A'          ; Comparar con 'A'
    JZ ES_VOCAL_FIN
    CMP AL, 'E'          ; Comparar con 'E'
    JZ ES_VOCAL_FIN
    CMP AL, 'I'          ; Comparar con 'I'
    JZ ES_VOCAL_FIN
    CMP AL, 'O'          ; Comparar con 'O'
    JZ ES_VOCAL_FIN
    CMP AL, 'U'          ; Comparar con 'U'
    JZ ES_VOCAL_FIN
    CMP AL, 'a'          ; Comparar con 'a'
    JZ ES_VOCAL_FIN
    CMP AL, 'e'          ; Comparar con 'e'
    JZ ES_VOCAL_FIN
    CMP AL, 'i'          ; Comparar con 'i'
    JZ ES_VOCAL_FIN
    CMP AL, 'o'          ; Comparar con 'o'
    JZ ES_VOCAL_FIN
    CMP AL, 'u'          ; Comparar con 'u'
    JZ ES_VOCAL_FIN

    MOV AL, 00H          ; Si no es vocal, poner 00H
    RET

ES_VOCAL_FIN:
    MOV AL, 0FFH         ; Si es vocal, poner 0FFH
    RET
