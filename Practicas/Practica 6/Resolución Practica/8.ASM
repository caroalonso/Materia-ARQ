;8)

.data
CONTROL: .word32 0x10000
DATA: .word32 0x10008
color_pelota_1: .word32 0x00FF0000  # Rojo
color_pelota_2: .word32 0x0000FF00  # Verde
color_pelota_3: .word32 0x000000FF  # Azul
color_pelota_4: .word32 0x00FFFF00  # Amarillo
color_pelota_5: .word32 0x00FF00FF  # Magenta
color_fondo: .word32 0x00FFFFFF      # Blanco

# Estructura de datos para cinco pelotitas
pelotas_x: .word32 10, 20, 30, 40, 50  # Posición X inicial
pelotas_y: .word32 10, 15, 25, 35, 45  # Posición Y inicial
direcciones_x: .word32 1, -1, 1, -1, 1  # Dirección en X
direcciones_y: .word32 1, 1, -1, -1, 1  # Dirección en Y
colores: .word32 0x00FF0000, 0x0000FF00, 0x000000FF, 0x00FFFF00, 0x00FF00FF

.text
lwu $s6, CONTROL($zero)
lwu $s7, DATA($zero)

daddi $s5, $zero, 5  # Comando para dibujar un punto
daddi $t9, $zero, 5  # Cantidad de pelotitas

loop:
    daddi $t8, $zero, 0  # Índice de la pelotita

bucle_pelotas:
    sll $t0, $t8, 2  # Multiplica índice por 4 para acceder a las posiciones

    # Cargar posición, dirección y color de la pelota actual
    lw $s0, pelotas_x($t0)
    lw $s1, pelotas_y($t0)
    lw $s2, direcciones_x($t0)
    lw $s3, direcciones_y($t0)
    lw $v0, colores($t0)

    # Borrar la pelota (dibujando con el color de fondo)
    sw $color_fondo, 0($s7)
    sb $s0, 4($s7)
    sb $s1, 5($s7)
    sd $s5, 0($s6)

    # Mover la pelota en la dirección actual
    dadd $s0, $s0, $s2
    dadd $s1, $s1, $s3

    # Verificar colisiones con bordes
    daddi $t1, $zero, 48  # Límite derecho e inferior
    slt $t0, $t1, $s0
    dsll $t0, $t0, 1
    dsub $s2, $s2, $t0

    slt $t0, $t1, $s1
    dsll $t0, $t0, 1
    dsub $s3, $s3, $t0

    slti $t0, $s0, 1
    dsll $t0, $t0, 1
    dadd $s2, $s2, $t0

    slti $t0, $s1, 1
    dsll $t0, $t0, 1
    dadd $s3, $s3, $t0

    # Guardar nuevas posiciones y direcciones
    sw $s0, pelotas_x($t0)
    sw $s1, pelotas_y($t0)
    sw $s2, direcciones_x($t0)
    sw $s3, direcciones_y($t0)

    # Dibujar la pelota con su color
    sw $v0, 0($s7)
    sb $s0, 4($s7)
    sb $s1, 5($s7)
    sd $s5, 0($s6)

    # Siguiente pelota
    daddi $t8, $t8, 1
    blt $t8, $t9, bucle_pelotas

    # Demora para que la animación no sea demasiado rápida
    daddi $t0, $zero, 500
demora:
    daddi $t0, $t0, -1
    bnez $t0, demora

    j loop
