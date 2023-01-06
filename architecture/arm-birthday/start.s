@ The code in this file is just for testing purposes to help you make a
@ standalone program. It is not part of the assignment.

        .global _start
        .equ    sys_exit, 1
        .data
        .equ    test1, 1
        .equ    test2, 4
        .equ    test3, 23
        .text
_start:
        @ call birthday
        @ note: for test1, the expected output is "Success"
        @ note: for test2, the expected output is "Error 2"
        @ note: for test3, the expected output is "Error 51"
        mov     r0, #test1
        bl      birthday

        @ exit system call
        mov     r7, #sys_exit
        svc     #0
