.section .data
newline:    .asciz "\n"        // Salto de línea
msg:        .asciz "0"         // Mensaje a imprimir (un solo '0')

.section .text
.global create_matrix

create_matrix:
    str lr, [sp, -16]!         // Almacenar lr en la pila
    str x16, [sp, -16]!        // Almacenar x16 (número de filas)
    str x15, [sp, -16]!        // Almacenar x15 (número de ceros por fila)
    
    mov x16, x19                // Número de filas (repeticiones)
    mov x15, x19                // Número de "0"s por fila

loop_filas:
    cmp x16, #0                 // Comparar x16 con 0
    beq exit_create_matrix      // Si x16 es 0, salir del bucle

    mov x15, x19                // Reiniciar el contador de "0"s por fila

loop_columnas:
    cmp x15, #0                 // Comparar x15 con 0
    beq print_newline_create    // Si se han impreso todos los "0"s, imprimir salto de línea

    bl print_msg_create         // Llamar a la función para imprimir un "0"
    sub x15, x15, #1            // Decrementar el contador de "0"s
    b loop_columnas             // Volver a imprimir más "0"s

print_newline_create:
    ldr x0, =1                  // File descriptor (stdout)
    ldr x1, =newline            // Dirección del salto de línea ("\n")
    mov x2, #1                  // Longitud del salto de línea (1 byte)
    mov x8, 64                  // syscall: write
    svc 0                       // Llamar al sistema para escribir

    sub x16, x16, 1             // Decrementar el contador de filas
    b loop_filas                // Volver al bucle de filas

exit_create_matrix:
    // Restaurar registros
    ldr x15, [sp], 16           // Restaurar x15
    ldr x16, [sp], 16           // Restaurar x16
    ldr lr, [sp], 16            // Restaurar lr
    ret                          // Retornar

// Imprimir el mensaje "0"
print_msg_create:
    ldr x0, =1                  // File descriptor (stdout)
    ldr x1, =msg                // Dirección del mensaje ("0")
    mov x2, #1                  // Longitud del mensaje (1 byte)
    mov x8, 64                  // syscall: write
    svc 0                       // Llamar al sistema para escribir
    ret                         // Retornar

