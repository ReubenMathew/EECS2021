v1: DD 1, 5, -7, 23, -5
v2: DD 3, -2, 4, 11, -7

addi x10, x0, 40
add x5, x0, x0
addi x9, x0, 0
loop: 	ld x6, v1(x5) 
	ld x7, v2(x5)
	add x8, x7, x6
	sd x8, v3(x5)
	addi x5, x5, 8
	beq x5, x10, end
	bne x5, x10, loop

end: ebreak x0, x0, 0
v3: DM 1