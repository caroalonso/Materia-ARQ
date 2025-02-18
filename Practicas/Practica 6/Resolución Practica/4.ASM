;4)

                        .data
CLAVE_ALM:         .asciiz  "vamo"
CLAVE:             .asciiz  "0000"
BIEN:              .asciiz  "Bienvenido"
MAL:               .asciiz  "Error"
CONTROL:           .word32  0x10000
DATA:              .word32  0x10008
;
                        .code
              lwu    $a0, DATA($zero)
              daddi  $a1, $zero, 9
              lwu    $a2, CONTROL($zero)
    otra:     dadd   $t1, $zero, $zero
	      daddi  $t3, $zero, 4
	      daddi  $t8, $zero, 4
              jal    char
              jal    respuesta
               beqz  $t9, otra
              halt
;
    char:     sd   $a1, ($a2)
              lbu  $t2, ($a0)
	      sb  $t2, CLAVE($t1)
	      daddi $t1, $t1, 1
	      daddi $t3, $t3, -1
	      bnez $t3, char
              jr   R31
;
   respuesta:  dadd   $t1, $zero, $zero
               daddi  $t4, $zero, 4
               dadd   $t5, $zero, $zero
     sigo:     lbu    $t6, CLAVE($t1)
               lbu    $t7, CLAVE_ALM($t1)
               dsub   $t5, $t6, $t7
               daddi  $t1, $t1, 1
               bnez   $t5, error
               daddi  $t4, $t4, -1
               bnez   $t4, sigo
               daddi  $t2, $zero, BIEN
               sd     $t2, ($a0)
               sd     $t8, ($a2)
               j      afuera
   error:      daddi  $t2, $zero, MAL
               sd     $t2, ($a0)
               sd     $t8, ($a2)
               dadd   $t9, $zero, $zero
               j   afuera1
     afuera:   daddi  $t9, $zero, 1
     afuera1:  jr     $ra