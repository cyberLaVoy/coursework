local
    val reservedWords = [
        "define", "if", "while", "begin", "set"
    ]
    val unaryBuiltIns = [
        "car", "cdr", "number?", "symbol?", "list?", "null?", "print"
    ]
    val binaryBuiltIns = [
        "+", "-", "*", "/", "=", "<", ">", "cons"
    ]
in
    fun isReservedWord s = List.exists (fn elt => s = elt) reservedWords
    fun isUnaryBuiltIn s = List.exists (fn elt => s = elt) unaryBuiltIns
    fun isBinaryBuiltIn s = List.exists (fn elt => s = elt) binaryBuiltIns
    fun isBuiltIn s = isUnaryBuiltIn s orelse isBinaryBuiltIn s
end

datatype sxp =
    NilSxp
  | NumSxp of int
  | SymSxp of string
  | ListSxp of (sxp * sxp)

datatype expression =
    ValExp of sxp
  | VarExp of string
  | IfExp of (expression * expression * expression)
  | WhileExp of (expression * expression)
  | SetExp of (string * expression)
  | BeginExp of expression list
  | BinaryBuiltinExp of string * expression * expression
  | UnaryBuiltinExp of string * expression
  | ApExp of string * (expression list)

datatype topLevelInput =
    FunDef of (string * string list * expression)
  | Expression of expression

fun listToString f lst =
    let fun g [] s      = s
          | g [x] s     = s ^ f x
          | g (x::xs) s = g xs (s ^ f x ^ ", ")
    in "[" ^ g lst "" ^ "]" end

fun sxpToRepr NilSxp = "NilSxp"

  | sxpToRepr (NumSxp n) = "NumSxp " ^ Int.toString n

  | sxpToRepr (SymSxp s) = "SymSxp \"" ^ s ^ "\""

  | sxpToRepr (ListSxp (car, cdr)) =
        "ListSxp (" ^ sxpToRepr car ^ ", " ^ sxpToRepr cdr ^ ")"

fun sxpToString NilSxp = "()"

  | sxpToString (NumSxp n) = Int.toString n

  | sxpToString (SymSxp s) = s

  | sxpToString (lst as ListSxp pair) =
        let fun f prefix (ListSxp (car, cdr)) =
                    f ((if prefix = "" then "" else prefix^" ") ^ sxpToString car) cdr
              | f prefix NilSxp = prefix
              | f _ _ = "MALFORMED LIST"
        in "(" ^ f "" lst ^ ")" end

fun expressiontoRepr (ValExp v) = "ValExp (" ^ sxpToString v ^ ")"

  | expressiontoRepr (VarExp s) = "VarExp \"" ^ s ^ "\""

  | expressiontoRepr (IfExp (cond, thenPart, elsePart)) =
        "IfExp (" ^
        expressiontoRepr cond ^ ", " ^
        expressiontoRepr thenPart ^ ", " ^
        expressiontoRepr elsePart ^ ")"

  | expressiontoRepr (WhileExp (cond, body)) =
        "WhileExp (" ^
        expressiontoRepr cond ^ ", " ^
        expressiontoRepr body ^ ")"

  | expressiontoRepr (SetExp (name, exp)) =
        "SetExp (\"" ^ name ^ "\", " ^
        expressiontoRepr exp ^ ")"

  | expressiontoRepr (BeginExp lst) =
        "Begin " ^ listToString expressiontoRepr lst

  | expressiontoRepr (BinaryBuiltinExp (name, left, right)) =
        "BinaryBuiltinExp (\"" ^ name ^ "\", " ^
        expressiontoRepr left ^ ", " ^
        expressiontoRepr right ^ ")"

  | expressiontoRepr (UnaryBuiltinExp (name, exp)) =
        "UnaryBuiltinExp (\"" ^ name ^ "\", " ^
        expressiontoRepr exp ^ ")"

  | expressiontoRepr (ApExp (name, argList)) =
        "ApExp (\"" ^ name ^
        "\", " ^ listToString expressiontoRepr argList ^ ")"

fun funDefToString (name, formals, body) =
    "FunDef (\"" ^ name ^
    "\", " ^ listToString (fn x => "\"" ^ x ^ "\"") formals ^ ", " ^
    expressiontoRepr body ^ ")"
