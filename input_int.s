.section .data
buffer: .space 100

.section .text
.global input

input:
	mov x0, 0
	ldr x1, =buffer
	mov x2, 100
	mov x8, 63
	svc 0

	ldr x1, =buffer
	mov x2, 0
	mov x3, 0

	mov x5, 10

convert_loop:
	ldrb w4, [x1], 1
	cmp w4, #'0'
	blt end_convert
	cmp w4, #'9'
	bgt end_convert

	sub w4, w4, '0'
	mov x3, x4
	mul x2, x2, x5
	add x2, x2, x3
	b convert_loop

end_convert:
	mov x0, x2
	ret
