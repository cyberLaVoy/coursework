exception NotImplemented

(* Write a function cube of type int -> int that returns the cube of
its parameter *)

fun cube x = x*x*x

(* Write a function cuber of type real -> real that returns the cube
of its parameter *)

fun cuber x : real = x*x*x

(* Write a function fourth of type 'a list -> 'a that returns the
fourth element of a list. Your function need not behave well on
lists with less than four elements. *)

fun fourth L = List.nth (L, 3)

(* Write a function min3 of type int * int * int -> int that returns
the smallest of three integers *)
fun min2 (x, y) =
	if x < y then x
	else y

fun min3 (x, y, z) = min2 ( min2 (y, x) , z )


fun min2r (x:real, y:real) =
	if x < y then x
	else y

fun min3r (x:real, y:real, z:real) = min2r ( min2r (y, x) , z )

fun max2r (x:real, y:real) =
	if x > y then x
	else y 

fun max3r (x:real, y:real, z:real) = max2r ( max2r (y, x) , z )

fun mid3r (x:real, y:real, z:real) =
	if (y <= x andalso x <= z) orelse (z <= x andalso x <= y) then x
	else if (x <= y andalso y <= z) orelse (z <= y andalso y <= x) then y
	else z
	 

(* Write a function red3 of type 'a * 'b * 'c -> 'a * 'c that
converts a tuple with three elements into one with two by elminating
the second element *)

fun red3 (x, y, z) = (x, z)

(* Write a function thirds of type string -> char that returns the
third character of a string. Your function need not behave well on
strings with lengths less than 3 *)

fun thirds s =  String.sub (s, 2)

(* Write a function cycle1 of type 'a list -> 'a list whose output
list is the same as the input list, but with the first element of
the list moved to the end. For example, cycle1 [1,2,3,4] shoudl
return [2,3,4,1] *)

fun cycle1 L = List.drop (L, 1) @ [hd L]

(* Write a function sort3 of type real * real * real -> real list
that returns a sorted list of three real numbers *)

fun sort3 (x, y, z) = [min3r (x, y, z), mid3r (x, y, z) , max3r (x, y, z)]

(* Write a function del3 of type 'a list -> 'a list whose output
list is the same as the input list, but with the third element
deleted. Your function need not behave well on lists with lengths
less than 3 *)

fun del3 L = List.take (L, 2) @ List.drop (L, 3)

fun deli (L, i) = List.take (L, i) @ List.drop (L, i+1)

(* Write a function sqsum of type int -> int that takes a
non-negative integer n and returns the sum of the squares of all the
integers 0 through n. Your function need not behave well on inputs
less than zero *)

fun sqsum x = 
	if x = 0 then 0
	else x*x + sqsum (x-1)

(* Write a function cycle of type 'a list * int -> 'a list that
takes a list and an integer n as input and returns the same list,
but with the first element cycled to the end of the list n times.
(Make use of your cycle1 function from a previous exercise.) For
example, cycle ([1,2,3,4,5,6],2) should return the list
[3,4,5,6,1,2] *)

fun cycle (L, i) =  
	if i = 0 then L
	else cycle ( cycle1 L, i-1 )

(* Write a function pow of type real * int -> real that raises a
real number to an integer power. Your function need not behave well
if the integer power is negative *)

fun pow (x:real, a) = 
	if a = 0 then 1.0
	else x * pow (x, a-1)

(* Write a function max of type int list -> int that returns the
largest element of a list of integers. Your function need not behave
well if the list is empty. Hint: Write a helper function maxhelper
that takes as a second parameter the largest element seen so far.
Then you can complete the exercise by defining

    fun max x = maxhelper (tl x, hd x)
*)

fun maxhelper (L, max) = 
	if length L = 0 then max
	else if hd L > max then maxhelper (tl L, hd L)
	else maxhelper (tl L, max)

fun max L = maxhelper (tl L, hd L)

(* Write a function isPrime of type int -> bool that returns true
if and only if its integer parameter is a prime number. Your
function need not behave well if the parameter is negative *)
fun isPrimeR (x, i) =
	if x <= 2 then x = 2
	else if x mod i = 0 then false
	else if i*i > x then true
	else isPrimeR(x, i+1)

fun isPrime x = isPrimeR(x, 2) 

(* Write a function select of type 'a list * ('a -> bool) -> 'a list
that takes a list and a function f as parameters. Your function
should apply f to each element of the list and should return a new
list containing only those elements of the original list for which f
returned true. (The elements of the new list may be given in any
order.) For example, evaluating select ([1,2,3,4,5,6,7,8,10],
isPrime) should result in a list like [7,5,3,2]. This is an example
of a higher-order function, since it takes another function as a
parameter *)


fun select (L, f) = List.filter f L;