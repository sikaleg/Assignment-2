.data
prompt1: .asciiz "Enter a \n"
prompt2: .asciiz "Enter b \n"
prompt3: .asciiz "Enter c \n"
prompt4: .asciiz "Complex roots \n"
prompt5: .asciiz " x1 and x2 is "
prompt6: .asciiz " and "

var1: .float 4
var2: .float 2
.text
lwc1 $f1,var1
lwc1 $f2,var2

#ask user for A value
li $v0,4
la $a0,prompt1
syscall
li $v0,6
syscall
mov.s $f3,$f0

#ask user for B value
li $v0,4
la $a0,prompt2
syscall
li $v0,6
syscall
mov.s $f4,$f0

#ask user for C value
li $v0,4
la $a0,prompt3
syscall
li $v0,6
syscall
mov.s $f5,$f0

#compute d
mul.s $f6,$f4,$f4	#b^2 = $f6
mul.s $f7,$f2,$f3	#2a = $f7
mul.s $f5,$f3,$f5	#ac = $f5
mul.s $f5,$f1,$f5	#4ac = $f5
sub.s $f6,$f6,$f5	#d = b^2 - 4ac ($f6)
#check if d<0
mfc1 $t1,$f6
blez $t1,complex
#compute roots
neg.s $f4,$f4	#-b = $f4
sqrt.s $f6,$f6 
#compute x1
add.s $f8,$f4,$f6	#-b+sqrt(d)
div.s $f9,$f8,$f7	#x1 = $f9
#compute x2
sub.s $f10,$f4,$f6	#-b-sqrt(d)
div.s $f11,$f10,$f7	#x2 = $f11

#print out result
li $v0,4
la $a0,prompt5
syscall

li $v0,2
mov.s $f12,$f9
syscall

li $v0,4
la $a0,prompt6
syscall

li $v0,2
mov.s $f12,$f11
syscall
b exit

complex:
li $v0,4
la $a0,prompt4
syscall

exit:
li $v0,10
syscall

