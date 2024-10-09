.section .data
newline_y:    .asciz "\n"       // Salto de línea
msg_y:        .asciz "0"        // Mensaje a imprimir (un solo '0')

.section .text
.global game_matrix_y
game_matrix_y:
    // Iniciar un bucle para obtener una entrada válida
input_loop:
    cmp x19, x30               // Comparar si el número de filas es mayor al tamaño permitido
    ble check_negative          // Si es menor o igual, continuar
    b input_error               // Si es mayor, mostrar error y solicitar nueva entrada

check_negative:
    cmp x19, 0                  // Comparar si x19 es menor que 1
    bge start_matrix_y          // Si es mayor o igual a 1, continuar
    b input_error               // Si es menor que 1, mostrar error y solicitar nueva entrada

start_matrix_y:
    mov x16, x19               // Número de filas (repeticiones)

loop_filas_y:
    cmp x16, #0                // Comparar x16 con 0
    beq exit_game_matrix_y     // Si x16 es 0, salir del bucle

    mov x15, x19               // Reiniciar el contador de "0"s por fila

loop_columnas_y:
    cmp x15, #0                // Comparar x15 con 0
    beq print_newline_game_y   // Si se han impreso todos los "0"s, imprimir salto de línea

    bl print_msg_game_y        // Imprimir "0" en la matriz Y
    sub x15, x15, #1           // Decrementar el contador de "0"s
    b loop_columnas_y          // Volver a imprimir más "0"s

// Imprimir el mensaje "0"
print_msg_game_y:
    ldr x0, =1                 // File descriptor (stdout)
    ldr x1, =msg_y             // Dirección del mensaje ("0")
    mov x2, #1                 // Longitud del mensaje (1 byte)
    mov x8, 64                 // syscall: write
    svc 0                      // Llamar al sistema para escribir
    ret

input_error:
    bl input                    // Volver a solicitar la entrada
    mov x19, x0                 // Almacenar el nuevo número en x19
    b input_loop                // Volver al inicio del bucle de entrada

// Imprimir el salto de línea
print_newline_game_y:
    ldr x0, =1                 // File descriptor (stdout)
    ldr x1, =newline_y         // Dirección del salto de línea ("\n")
    mov x2, #1                 // Longitud del salto de línea (1 byte)
    mov x8, 64                 // syscall: write
    svc 0                      // Llamar al sistema para escribir

    sub x16, x16, 1            // Decrementar el contador de filas
    b loop_filas_y             // Volver al bucle de filas

exit_game_matrix_y:
    mov x0, x0                        // Retornar cuando haya una salida
