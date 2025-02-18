;12a)Implementación de la subrutina factorial de forma recursiva

.data
valor: .word 10               # Valor para el cual se calculará el factorial
result: .word 0               # Donde se almacenará el resultado

.text
daddi $sp, $zero, 0x400       # Inicializa el puntero al tope de la pila
ld $a0, valor($zero)          # Carga el valor de la variable 'valor' en $a0
jal factorial                 # Llama a la subrutina factorial
sd $v0, result($zero)         # Almacena el resultado en 'result'
halt                          # Detiene la ejecución

factorial: 
    # Caso base: si n == 0, retorna 1
    beqz $a0, base_case       # Si $a0 (n) es 0, salta a base_case
    # Caso recursivo: n * factorial(n-1)
    daddi $a0, $a0, -1        # Decrementa n (n - 1)
    jal factorial             # Llama recursivamente a factorial(n-1)
    # Después de la llamada recursiva, $v0 contiene factorial(n-1)
    dmul $v0, $v0, $a0        # Multiplica el resultado por n (en $a0)
    jr $ra                     # Regresa de la subrutina

base_case:
    daddi $v0, $zero, 1       # Si n == 0, retorna 1
    jr $ra                     # Regresa de la subrutina
