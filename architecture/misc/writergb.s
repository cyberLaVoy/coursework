
r4 = buffer
r5 = color

logically shift and mask (isolate colors)

mov r1, #0xff
and r1, r1, r0, lsr #16

mov r1, #0xff
and r1, r1, r0, lsr #8

mov r1, #0xff
and r1, r1, r0

0x112233
0x [11] [22] [33]

isolate and send to itoa
write to buffer
17 34 51

return 8 (number of bytes written)
