.section .data
check:      .asciz "1"         // Mensaje a imprimir (un solo '1')

.section .text
.global play

play:
    str lr, [sp, -16]!         // Almacenar lr en la pila
    str x16, [sp, -16]!        // Almacenar x16 (número de filas)
    str x15, [sp, -16]!        // Almacenar x15 (número de ceros por fila)
    
    mov x14, 3 // Posicion x (columna)
    mov x13, 3 // Posicion y (fila)

    mov x16, x19                // Número de filas (repeticiones)
    mov x15, x19                // Número de "0"s por fila

play_filas:
    cmp x16, #0                 // Comparar x16 con 0
    beq exit_play               // Si x16 es 0, salir del bucle

    mov x15, x19                // Reiniciar el contador de "0"s por fila

play_columnas:
    cmp x15, #0                 // Comparar x15 con 0
    beq play_newline            // Si se han impreso todos los "0"s, imprimir salto de línea

    cmp x15, x14                // Comparar x15 (columna actual) con x14
    bne print_msg_play          // Si no son iguales, imprimir "0"

    cmp x16, x13                // Comparar x16 (fila actual) con x13
    bne print_msg_play          // Si no son iguales, imprimir "0"

    // Si son iguales, imprimir "1"
    bl print_msg_check_play     // Imprimir "1"
    b play_columnas             // Volver a imprimir más "0"s

print_msg_play:
    ldr x0, =1                  // File descriptor (stdout)
    ldr x1, =msg                // Dirección del mensaje ("0")
    mov x2, #1                  // Longitud del mensaje (1 byte)
    mov x8, 64                  // syscall: write
    svc 0                       // Llamar al sistema para escribir
    ret                         // Retornar

print_msg_check_play:
    ldr x0, =1                  // File descriptor (stdout)
    ldr x1, =check              // Dirección del mensaje ("1")
    mov x2, #1                  // Longitud del mensaje (1 byte)
    mov x8, 64                  // syscall: write
    svc 0                       // Llamar al sistema para escribir
    ret                         // Retornar

play_newline:
    ldr x0, =1                  // File descriptor (stdout)
    ldr x1, =newline            // Dirección del salto de línea ("\n")
    mov x2, #1                  // Longitud del salto de línea (1 byte)
    mov x8, 64                  // syscall: write
    svc 0                       // Llamar al sistema para escribir

    sub x16, x16, 1             // Decrementar el contador de filas
    b play_filas                // Volver al bucle de filas

exit_play:
    // Restaurar registros
    ldr x15, [sp], 16           // Restaurar x15
    ldr x16, [sp], 16           // Restaurar x16
    ldr lr, [sp], 16            // Restaurar lr
    ret                          // Retornar
