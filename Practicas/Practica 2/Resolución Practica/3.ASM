; Escribir un programa que muestre en pantalla las letras del abecedario, sin espacios, intercalando mayúsculas y
; minúsculas (AaBb…), sin incluir texto en la memoria de datos del programa. T
; Tener en cuenta que el código de “A” es 41H, el de “a” es 61H y que el resto de los códigos son correlativos según el abecedario

      ORG 1000H
LETRA DB  41H     

      ORG 2000H
      MOV AH, 27  
      MOV BX, OFFSET LETRA
      MOV AL, 1
SIGO: INT 7
      ADD BYTE PTR [BX], 20H 
      INT 7
      SUB BYTE PTR [BX], 20H  
      ADD BYTE PTR [BX], 1 
      DEC AH
      JNZ SIGO
      HLT
      END