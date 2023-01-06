@ The code in this file is just for testing purposes to help you make a
@ standalone program. It is not part of the assignment.

        .global _start
        .equ    sys_exit, 1
        .data
test1:  .asciz "-123"
test2:  .asciz "021stuff"
test3:  .asciz "-48"
        .text
_start:
        @ call stoi
        @ note: for test1, the expected output is "Error 123"
        @ note: for test2, the expected output is "Error 21"
        @ note: for test3, the expected output is "Error 208"
        ldr     r0, =test1
        bl      stoi

        @ exit system call
        mov     r7, #sys_exit
        svc     #0
