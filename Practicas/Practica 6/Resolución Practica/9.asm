;9)


.data
screen_base: .word 0x10008000  # Dirección base de la pantalla gráfica
cursor_x: .word 25  # Posición inicial X del cursor
cursor_y: .word 25  # Posición inicial Y del cursor
draw_mode: .word 0  # Modo de dibujo (0 = desplazamiento, 1 = dibujo)
color: .word 1  # Color inicial

.text
.globl main

main:
    li $v0, 5   # Código de syscall para leer teclado
    syscall
    move $t0, $v0  # Guardar tecla presionada en $t0

    # Movimiento del cursor
    lw $t1, cursor_x
    lw $t2, cursor_y

    li $t3, 'w'
    beq $t0, $t3, move_up
    li $t3, 's'
    beq $t0, $t3, move_down
    li $t3, 'a'
    beq $t0, $t3, move_left
    li $t3, 'd'
    beq $t0, $t3, move_right

    # Alternar modo dibujo con barra espaciadora
    li $t3, 32
    beq $t0, $t3, toggle_draw_mode

    # Cambiar color con teclas '1' a '8'
    li $t3, '1'
    blt $t0, $t3, main
    li $t3, '8'
    bgt $t0, $t3, main
    sub $t0, $t0, 48  # Convertir ASCII a número
    sw $t0, color
    j main

move_up:
    bgt $t2, 0, decrement_y
    j main
move_down:
    blt $t2, 49, increment_y
    j main
move_left:
    bgt $t1, 0, decrement_x
    j main
move_right:
    blt $t1, 49, increment_x
    j main

decrement_y:
    sub $t2, $t2, 1
    j update_cursor
increment_y:
    add $t2, $t2, 1
    j update_cursor
decrement_x:
    sub $t1, $t1, 1
    j update_cursor
increment_x:
    add $t1, $t1, 1
    j update_cursor

toggle_draw_mode:
    lw $t4, draw_mode
    xori $t4, $t4, 1  # Alternar entre 0 y 1
    sw $t4, draw_mode
    j main

update_cursor:
    sw $t1, cursor_x
    sw $t2, cursor_y

    # Si está en modo dibujo, pintar el punto
    lw $t4, draw_mode
    beqz $t4, main  # Si está en modo desplazamiento, no pinta

    lw $t5, color
    la $t6, screen_base
    mul $t7, $t2, 50  # Calcular fila
    add $t7, $t7, $t1  # Calcular dirección
    add $t6, $t6, $t7  # Dirección en memoria
    sb $t5, 0($t6)  # Pintar punto

    j main
