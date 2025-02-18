;7)

.data
msg: .asciiz "Ingrese un caracter: "   # Mensaje para solicitar entrada
buffer: .space 1                        # Espacio para el carácter ingresado
newline: .asciiz "\n"

# Matriz de puntos para el '8' (7 columnas x 9 filas)
char_8:
    .byte 0b0111110
    .byte 0b1000001
    .byte 0b1000001
    .byte 0b0111110
    .byte 0b1000001
    .byte 0b1000001
    .byte 0b0111110

.text
.globl main

main:
    # Solicitar un carácter al usuario
    li $v0, 4
    la $a0, msg
    syscall

    # Leer un carácter desde la entrada estándar
    li $v0, 8
    la $a0, buffer
    li $a1, 2  # Leer un solo carácter más el '\0'
    syscall

    # Cargar el carácter ingresado
    lb $t0, buffer  # Cargar el carácter en $t0

    # Verificar si es el carácter '8'
    li $t1, '8'
    bne $t0, $t1, exit  # Si no es '8', salir

    # Si es '8', imprimir su representación
    la $t2, char_8  # Cargar dirección de la matriz

    li $t3, 9  # Contador de filas

print_matrix:
    lb $t4, 0($t2)  # Cargar fila actual
    li $t5, 7  # Contador de columnas

print_row:
    andi $t6, $t4, 0x40  # Tomar bit más significativo
    beqz $t6, print_space

    # Imprimir '*'
    li $v0, 11
    li $a0, '*'
    syscall
    j print_next

print_space:
    # Imprimir ' '
    li $v0, 11
    li $a0, ' '
    syscall

print_next:
    sll $t4, $t4, 1  # Desplazar a la izquierda para siguiente bit
    daddi $t5, $t5, -1
    bnez $t5, print_row  # Seguir mientras queden columnas

    # Imprimir nueva línea
    li $v0, 4
    la $a0, newline
    syscall

    daddi $t2, $t2, 1  # Siguiente fila
    daddi $t3, $t3, -1
    bnez $t3, print_matrix  # Seguir mientras haya filas

exit:
    li $v0, 10
    syscall
