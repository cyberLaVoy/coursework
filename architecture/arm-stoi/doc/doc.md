String to integer
=================

Write a function called `stoi` to convert a string containing a base
10 number to an integer value. This is essentially the reverse of
the `itoa` function we wrote early in the semester.

    stoi(buffer) -> n

`stoi` is given the address of a buffer in memory containing a text
representation of an integer value. Here is the basic algorithm for
doing this:

*   start with n = 0
*   read a character from the buffer and call it c
*   if the value of c is between '0' and '9' (48 and 57):
    *   n = n * 10 + (c - '0')
    *   read the next character from the buffer and repeat
*   else return n

Note that you do not know in advance how many characters make up the
number. As soon as you read something that is not a digit, you
should assume you have reached the end of the input.

This reads characters in order, so you do NOT need to reverse
anything like you did in `itoa`.

In addition to the outline given above, you should accept an
optional `-` (minus sign) at the beginning of the input, and return
a negative number instead of a positive number.

For example, if `stoi` is called with 0x1230 as the value of the
buffer pointer, and memory contains the following:

* 0x1230: '3' (ASCII code 51)
* 0x1231: '8' (ASCII code 56)
* 0x1232: '0' (ASCII code 48)
* 0x1233: '1' (ASCII code 49)
* 0x1234: '2' (ASCII code 50)
* 0x1235: ' ' (ASCII code 32)

Your function should return the number 38012.


Hints
-----

Remember that you can load a single byte from memory by appending a
'b' to a normal load instruction:

    ldrb r0, [r1]

To multiply a number by 10, you can use a series of shifts and adds.
Every time a number is shifted left, it is effectively multiplied by
two. For example, to multiply r0 by 5, you could use:

    add r0, r0, r0, lsl #2

This adds r0×4 to r0, giving r0×5. You could double this value again
to get the original value multiplied by 10.
