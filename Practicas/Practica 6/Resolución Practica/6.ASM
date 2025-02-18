;6)

.data
base:      .double 0.0   # Almacena la base ingresada por el usuario
exponente: .word32 0     # Almacena el exponente ingresado por el usuario
resultado: .double 1.0   # Almacena el resultado (inicializado en 1)
mensajeBase:    .asciiz "Ingrese la base (punto flotante): "
mensajeExpo:    .asciiz "Ingrese el exponente (entero positivo): "
mensajeRes:     .asciiz "Resultado: "
saltoLinea:     .asciiz "\n"

CONTROL: .word32 0x10000
DATA:    .word32 0x10008

.text
lwu $s6, CONTROL($zero)  # Dirección de CONTROL
lwu $s7, DATA($zero)     # Dirección de DATA

# Mostrar mensaje para ingresar base
daddi $t0, $zero, 4      # Código para imprimir cadena
sd $t0, 0($s6)           # Enviar comando de impresión
dla $t1, mensajeBase     # Cargar dirección del mensaje
sd $t1, 0($s7)           # Enviar mensaje a DATA
sd $t0, 0($s6)           # Confirmar impresión

# Leer base (punto flotante)
daddi $t0, $zero, 7      # Código para leer float
sd $t0, 0($s6)           # Activar entrada
ldc1 $f0, 0($s7)         # Guardar base en $f0
sdc1 $f0, base           # Almacenar en memoria

# Mostrar mensaje para ingresar exponente
daddi $t0, $zero, 4
sd $t0, 0($s6)
dla $t1, mensajeExpo
sd $t1, 0($s7)
sd $t0, 0($s6)

# Leer exponente (entero positivo)
daddi $t0, $zero, 5
sd $t0, 0($s6)
lwu $t1, 0($s7)         # Guardar exponente en $t1
sw $t1, exponente       # Almacenar en memoria

# Llamar a subrutina a_la_potencia
jal a_la_potencia

# Mostrar mensaje del resultado
daddi $t0, $zero, 4
sd $t0, 0($s6)
dla $t1, mensajeRes
sd $t1, 0($s7)
sd $t0, 0($s6)

# Mostrar resultado
daddi $t0, $zero, 8      # Código para imprimir float
sd $t0, 0($s6)           
ldc1 $f2, resultado      # Cargar resultado
sdc1 $f2, 0($s7)         # Enviar a DATA
sd $t0, 0($s6)           # Imprimir

# Salto de línea
daddi $t0, $zero, 4
sd $t0, 0($s6)
dla $t1, saltoLinea
sd $t1, 0($s7)
sd $t0, 0($s6)

halt                     # Terminar ejecución

# Subrutina para calcular la potencia
a_la_potencia:
    ldc1 $f1, base        # Cargar la base
    ldc1 $f2, resultado   # Cargar resultado (1.0 inicial)
    lw $t2, exponente     # Cargar exponente en $t2

    daddi $t3, $zero, 0   # Contador i = 0
    daddi $t4, $zero, 1   # Constante 1 para comparación

    # Si exponente es 0, devolver 1
    bnez $t2, loop_inicio
    sdc1 $f2, resultado   # Almacenar 1.0 como resultado
    jr $ra                # Retornar

loop_inicio:
    mul.d $f2, $f2, $f1   # Multiplicar resultado * base
    daddi $t3, $t3, 1     # Incrementar contador
    bne $t3, $t2, loop_inicio  # Repetir hasta que i == exponente

    sdc1 $f2, resultado   # Guardar resultado final en memoria
    jr $ra                # Retornar
