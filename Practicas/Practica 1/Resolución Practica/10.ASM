;10) Escriba la subrutina RESTO que calcule el resto de la división entre 2 números positivos. Dichos números deben
;pasarse por valor desde el programa principal a la subrutina a través de registros.

ORG 1000H                 ; Dirección de inicio del programa
DIVIDENDO    DB      127  ; Valor del dividendo (127)
DIVISOR      DB       10  ; Valor del divisor (10)

; Subrutina RESTO: Calcula el resto de la división entre AH (dividendo) y CL (divisor)
ORG 3000H
RESTO:  
    CMP  AH, CL           ; Compara el dividendo (AH) con el divisor (CL)
    JNC  RESTO            ; Si AH es mayor o igual que CL, sigue con la resta
    MOV  AL, AH           ; Si AH es menor que CL, el resto es AH (el dividendo original)
    RET                   ; Regresa de la subrutina

RESTO_LOOP:
    SUB  AH, CL           ; Resta el divisor (CL) del dividendo (AH)
    JNC  RESTO_LOOP       ; Si el resultado es mayor o igual a 0, sigue restando
    MOV  AL, AH           ; Si AH es menor que CL, el valor de AH es el resto
    RET                   ; Regresa de la subrutina

; Programa principal: Llama a la subrutina RESTO para calcular el resto
ORG 2000H
    MOV  AH, DIVIDENDO    ; Carga el dividendo en AH
    MOV  CL, DIVISOR      ; Carga el divisor en CL
    CALL RESTO            ; Llama a la subrutina para calcular el resto
    HLT                   ; Fin del programa

END
