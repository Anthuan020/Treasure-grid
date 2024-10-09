.section .data

.section .text
.global _start
.include "matriz_print.s"  // Incluir la impresión de la primera matriz
.include "input_int.s"     // Incluir la entrada del número
.include "validaciones.s"   // Incluir la impresión de la segunda matriz
.include "play.s"

_start:
    // Obtener el input del tamaño de la primera matriz
	bl input
	mov x19, x0               // Guardar el tamaño en x19 para la matriz 1
	mov x17, x0               // También guardar el tamaño del mapa del juego en x30
	bl create_matrix          // Llamar a la función que crea la primera matriz

	bl input
	mov x19, x17
	bl play
    // Salir del programa correctamente
    mov x0, 0                 // Código de salida 0
    mov x8, 93                // syscall: exit
    svc 0                     // Llamar al sistema para salir
