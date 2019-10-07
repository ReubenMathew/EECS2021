str1: DC "sampled text\0"
addi a2, x0, str1+6 ;chaddr
jal x1, delch1
addi x6, x0, str1 ;output
ecall x0, x6, 4
ebreak x0, x0, 0 ;finish