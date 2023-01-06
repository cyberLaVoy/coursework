exception Not_implemented

(* These exercises all have one-line solutions using map, foldr, or
   foldl. You can also use other predefined functions, but do NOT
   write any additional named functions and do NOT use explicit
   recursion. If you need helper functions, use anonymous ones. For
   example, if the problem says "write a function add2 that takes an
   int list and returns the same list with 2 added to every
   element", your answer should be

      fun add2 x = map (fn a => a + 2) x

   You have seen some of these problems before. The trick now is to
   solve them in this new, concise form. *)

(* Write a function il2rl of type int list -> real list that takes a
   list of integers and returns a list of the same numbers converted
   to type real. For example, if you evaluate il2rl [1,2,3] you
   should get [1.0,2.0,3.0]. *)

fun il2rl L = map ( fn x => Real.fromInt x ) L

(* Write a function ordlist of type char list -> int list that takes
   a list of characters and returns the list of the integer codes of
   those characters. For example, if you evaluate ordlist
   [#"A",#"b",#"C"] you should get [65,98,67]. *)

fun ordlist L = map ( fn x => Char.ord x ) L

(* Write a function squarelist of type int list -> int list that
   takes a list of integers and returns a list of the squares of
   those integers. For example, if you evaluate squarelist [1,2,3,4]
   you should get [1,4,9,16]. *)

fun squarelist L = map ( fn x => x*x ) L

(* Write a function multpairs of type (int * int) list -> int list
   that takes a list of pairs of integers and returns a list of the
   products of each pair. For example, if the input is
   [(1,2), (3,4)], your function should return [2,12]. *)

fun multpairs L = map (fn item => op* item) L

(* Write a function inclist of type int list -> int -> int list that
   takes a list of integers and an integer increment, and returns
   the same list of integers but with the integer increment added to
   each one. For example, if you evaluate inclist [1,2,3,4] 10 you
   should get [11,12,13,14]. Note that the function is curried. *)

fun inclist L i = map (fn x => x+i) L

(* Write a function sqsum of type int list -> int that takes a list
   of integers and returns the sum of the squares of those integers.
   For example, if you evalute sqsum [1,2,3,4] you should get 30. *)

fun sqsum L = foldl (fn (x, acc) => acc + x*x) 0 L

(* Write a function bor of type bool list -> bool that takes a list
   of boolean values and returns the logical OR of all of them. If
   the list is empty, your function should return false. *)

fun bor L = List.exists (fn b => b) L

(* Write a function band of type bool list -> bool that takes a list
   of boolean values and returns the logical AND of all of them. If
   the list is empty, your function should return true. *)

fun band L = List.all (fn b => b) L

(* Write a function bxor of type bool list -> bool that takes a list
   of boolean values and returns the logical exclusive OR of all of
   them. (It should return true if the number of true values in the
   list is odd and false if the number of true values is even.) If
   the list is empty, your function should return false. *)

fun bxor L = ( foldl (fn (x, acc) => acc+(if x then 1 else 0) ) 0 L ) mod 2 <> 0

(* Write a function duplist of type 'a list -> 'a list whose output
   list is the same as the input list, but with each element of the
   input list repeated twice in a row. For example, if the input
   list is [1,3,2], the output list should be [1,1,3,3,2,2]. If the
   input list is [], the output list should be []. *)

fun duplist L = foldl (fn (x, acc) => acc @ [x, x]) [] L

(* Write a function mylength of type 'a list -> int that returns the
   length of a list. (Of course, you may not use the predefined
   length function to do it. *)

fun mylength L = foldl (fn (x, acc) => acc+1) 0 L

(* Write a function il2absrl of type int list -> real list that
   takes a list of integers and returns a list containing the
   absolute value of those integers, converted to real numbers. *)

fun il2absrl L = map (fn x => Real.fromInt (if x < 0 then 0-x else x)) L

(* Write a function truecount of type bool list -> int that takes a
   list of boolean values and returns the number of trues in the
   list. *)

fun truecount L = foldl (fn (x, acc) => acc + ( if x then 1 else 0 )) 0 L

(* Write a function maxpairs of type (int * int) list -> int list
   that takes a list of pairs of integers and returns the list of
   the max elements from each pair. For example, if you evaluate
   maxpairs [(1,3), (4,2), (~3,~4)] you should get [3,4,~3]. *)

fun maxpairs L = map (fn (x, y) => if x > y then x else y) L

(* Write a function myimplode that works just like the predefined
   implode. In other words, it should be a function of type
   char list -> string that takes a list of characters and returns
   the string containing those same characters in the same order. *)

fun myimplode L = foldr (fn (x, acc) => Char.toString x ^ acc) "" L

(* Write a function lconcat of type 'a list list -> 'a list that
   takes a list of lists as input and returns the list formed by
   appending the input lists together in order. For example, if the
   input is [[1,2], [3,4,5,6], [7]], your function should return
   [1,2,3,4,5,6,7]. (There is a predefined function like this called
   concat, which of course you should not use.) *)

fun lconcat L = foldr (fn (x, acc) => x@acc) [] L

(* Write a function max of type int list -> int that returns the
   largest element of a list of integers. Your function need not
   behave well if the list is empty. *)

fun max L = foldl (fn (x, acc) => if x > acc then x else acc) (hd L) L

(* Write a function min of type int list -> int that returns the
   smallest element of a list of integers. Your function need not
   behave well if the list is empty. *)

fun min L = foldl (fn (x, acc) => if x < acc then x else acc) (hd L) L

(* Write a function member of type ''a * ''a list -> bool so that
   member (e,L) is true if and only if e is an element of list L. *)

fun member (e, L) = foldl (fn (x, acc) => if acc then acc else if x = e then true else false ) false L

(* Write a function append of type 'a list -> 'a list -> 'a list
   that takes two lists and returns the result of appending the
   second one onto the end of the first. For example, append [1,2,3]
   [4,5,6] should evaluate to [1,2,3,4,5,6]. Do not use the
   predefined appending utilities, like the @ operator or the
   contact function. Note that the function is curried. *)

fun append L M = foldr (fn (x, acc) => x::acc) M L

(* Define a function less of type int * int list -> int list so that
   less (e,L) is a list of all the integers in L that are less than
   e (in any order). *)

fun less (e, L) = foldl (fn (x, acc) => if x < e then x::acc else acc) [] L

(* Write a function evens of type int list -> int list that takes a
   list of integers and returns the list of all the even elements
   from the original list (in the original order). For example, if
   you evaluate evens [1,2,3,4] you should get [2,4]. *)

fun evens L = foldr (fn (x, acc) => if x mod 2 = 0 then x::acc else acc) [] L

(* Write a function convert of type ('a * 'b) list -> 'a list * 'b * list,
   that converts a list of pairs into a pair of lists, preserving
   the order of the elements. For example, convert [(1,2), (3,4),
   (5,6)] should evaluate to ([1,3,5], [2,4,6]). *)

fun convert L = foldr (fn ((x, y), (acc0, acc1)) => (x::acc0, y::acc1) ) ([], []) L

(* Define a function mymap with the same type and behavior as map,
   but without using map. (Note this should still be a one-liner:
   use foldl or foldr.) *)

fun mymap f L = foldr (fn (x, acc) => (f x) :: acc) [] L


(* Represent a polynomial using a list of its (real) coefficients,
   starting with the constant coefficient and going only as high as
   necessary. For example, 3x²+5x+1 would be represented as the list
   [1.0,5.0,3.0] and x³-2x as [0.0,~2.0,0.0,1.0]. Write a function
   eval of type real list -> real -> real that takes a polynomial
   represented this way and a value for x and returns the value of
   that polynomial at the given x. For example, eval
   [1.0,5.0,3.0] 2.0 should evaluate to 23.0, because when x=2,
   3x²+5x+1=23. (This is the same as the problem from the previous
   problem set, except that now it is a curried function and must be
   written as a one liner.) *)

fun eval L x = hd ( foldl (fn (c, s::m::empty) => [s + c*m, m*x]) [0.0, 1.0] L )
