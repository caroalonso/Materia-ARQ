;4) Escribir una subrutina ROTARIZ que haga una rotación hacia la izquierda de los bits de un byte almacenado en la
;memoria del microprocesador. Dicho byte y el número de posiciones a rotar deben pasarse por valor desde el programa
;principal a la subrutina a través de registros.

        ORG 1000H  ; Memoria de datos
BYTE    DB  0AH    ; Ejemplo: 00001010 (10 en decimal)
RESULT  DB  ?      ; Espacio para guardar el resultado

        ORG 3000H  ; Subrutina ROTARIZ
ROTARIZ: 
        MOV CL, DL  ; Número de posiciones a rotar (DL → CL)
        ROL AL, CL  ; Rotar AL a la izquierda CL veces
        RET

        ORG 2000H  ; Programa principal
        MOV AL, BYTE  ; Cargar el byte a rotar
        MOV DL, 3     ; Número de posiciones a rotar (ejemplo: 3)
        
        CALL ROTARIZ  ; Llamar a la subrutina
        
        MOV RESULT, AL ; Guardar el resultado
        
        HLT
        END
