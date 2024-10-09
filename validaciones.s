.section .data
.section .text
.global validaciones

validaciones:
    mov x15, x0               // Mover el valor de x0 a x15 para la validación

validacion_mayor:
    cmp x15, x30              // Comparar x15 (número ingresado) con x30 (tamaño del mapa)
    ble check_negative         // Si x15 <= x30, verificar si es negativo
    b error_validacion         // Si x15 > x30, ir a error de validación

check_negative:
    cmp x15, 0                // Comparar x15 con 0
    bge continue               // Si x15 >= 0, continuar
    b error_validacion         // Si x15 < 0, ir a error de validación

error_validacion:
    bl input                   // Llamar a input para volver a obtener un número
    mov x15, x0               // Actualizar x15 con el nuevo valor
    b validacion_mayor        // Repetir la validación

continue:
    // Restaurar los registros de la pila
    ret                        // Retornar
