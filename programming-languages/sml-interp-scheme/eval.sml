exception RuntimeError of string

(* note: you should populate globalEnv with all of the primitive operations *)
(* but you should never reference it directly anywhere else *)
local
    fun primop_add (NumSxp left, NumSxp right) = NumSxp (left+right)
        | primop_add _ = raise RuntimeError ("Invalid addition.")
    fun primop_sub (NumSxp left, NumSxp right) = NumSxp (left-right)
        | primop_sub _ = raise RuntimeError ("Invalid subtraction.")
    fun primop_mul (NumSxp left, NumSxp right) = NumSxp (left*right)
        | primop_mul _ = raise RuntimeError ("Invalid multiplication.")
    fun primop_div (NumSxp left, NumSxp right) = NumSxp (left div right)
        | primop_div _ = raise RuntimeError ("Invalid division.")
    fun primop_l (NumSxp left, NumSxp right) = (if left < right then SymSxp "T" else NilSxp)
        | primop_l _ = raise RuntimeError ("Invalid less than.")
    fun primop_g (NumSxp left, NumSxp right) = (if left > right then SymSxp "T" else NilSxp)
        | primop_g _ = raise RuntimeError ("Invalid greater than.")
    fun primop_e (NumSxp left, NumSxp right) = (if left = right then SymSxp "T" else NilSxp)
        | primop_e (SymSxp left, SymSxp right) = (if left = right then SymSxp "T" else NilSxp)
        | primop_e (NilSxp, NilSxp) = (SymSxp "T")
        | primop_e _ = NilSxp 
    fun primop_cons (left, NumSxp right) = raise RuntimeError ("Not a valid right hand expression.") 
        | primop_cons (left, SymSxp right) = raise RuntimeError ("Not a valid right hand expression.")
        | primop_cons (left, right) = ListSxp(left, right)
    fun primop_car (ListSxp(x, xs)) = x 
        | primop_car _ = raise RuntimeError("Invalid car.")
    fun primop_cdr (ListSxp(x, xs)) = xs 
        | primop_cdr _ = raise RuntimeError("Invalid cdr.")
    fun primop_print (v) = ( print ( (valueToString v) ^ "\n" ); v )
    fun primop_null (NilSxp) = SymSxp("T")
        | primop_null _ = NilSxp
    fun primop_symbol (SymSxp v) = SymSxp("T")
        | primop_symbol _ = NilSxp
    fun primop_list (ListSxp v) = SymSxp("T")
        | primop_list _ = NilSxp
    fun primop_num (NumSxp v) = SymSxp("T")
        | primop_num _ = NilSxp
    fun primop_primop (BinaryPrimOp (_,_)) = SymSxp("T")
        | primop_primop (UnaryPrimOp (_,_)) = SymSxp("T")
        | primop_primop _ = NilSxp
    fun primop_closure (Closure (_,_)) = SymSxp("T")
        | primop_closure _ = NilSxp
in
    val globalEnv: (string * value) list ref = ref [
        ("+", BinaryPrimOp("+", primop_add)),
        ("-", BinaryPrimOp("-", primop_sub)),
        ("*", BinaryPrimOp("*", primop_mul)),
        ("/", BinaryPrimOp("*", primop_div)),
        ("<", BinaryPrimOp("<", primop_l)),
        (">", BinaryPrimOp(">", primop_g)),
        ("=", BinaryPrimOp("=", primop_e)),
        ("cons", BinaryPrimOp("cons", primop_cons)),

        ("car", UnaryPrimOp("car", primop_car)),
        ("cdr", UnaryPrimOp("cdr", primop_cdr)),
        ("print", UnaryPrimOp("print", primop_print)),
        ("null?", UnaryPrimOp("null?", primop_null)),
        ("symbol?", UnaryPrimOp("symbol?", primop_symbol)),
        ("list?", UnaryPrimOp("list?", primop_list)),
        ("number?", UnaryPrimOp("number?", primop_num)),
        ("primop?", UnaryPrimOp("primop?", primop_primop)),
        ("closure?", UnaryPrimOp("closure?", primop_closure))
        ]
end

(* get an entry from a single environement *)
fun envGet env name =
    let fun f [] = NONE
          | f ((key, value) :: tail) =
                if key = name
                    then SOME value
                    else f tail
    in f (!env) end

(* update/create an entry in a single environement *)
fun envSet env key value =
    let fun f [] = [(key, value)]
          | f ((elt as (k, v)) :: tail) =
                if key = k
                    then (key, value) :: tail
                    else elt :: f tail
    in env := f (!env) end

(* check if a single environement contains a key *)
fun envContains env name =
    case envGet env name of SOME _ => true | NONE => false

(* create a new, empty environement *)
fun envNew () = ref []

(* your code goes here *)
(* note: in addition to implementing eval, you must also implement all *)
(* of the primitive operations and add them to the global environment *)
(* as UnaryPrimOp and BinaryPrimOp values *)
fun eval (rho, ValExp v) = v

    | eval (rho, LambdaExp lambda) = Closure(lambda, rho)

    | eval (rho, VarExp name) = 
        let fun f (env) = envContains env name
        in case List.find f rho of
            SOME env => valOf(envGet env name)
            | NONE => raise RuntimeError ("Variable " ^ name ^ " does not exist.")
        end

    | eval (rho, IfExp (cond, thenPart, elsePart) ) = 
        ( case eval(rho, cond) of
            NilSxp => eval(rho, elsePart)
            | _ => eval(rho, thenPart) )

    | eval (rho, WhileExp (cond, body) ) =
        ( case eval(rho, cond) of
          NilSxp => NilSxp
        | _ => eval(rho, WhileExp (cond, body) ) )

    | eval (rho, SetExp (name, exp)) = 
        let val v = eval(rho, exp)
            fun f (env) = envContains env name
        in case List.find f rho of
            SOME env => ((envSet env name v); v)
            | NONE => ((envSet (List.last rho) name v); v)
        end

    | eval (rho, BeginExp [exp]) = eval(rho, exp) 
    | eval (rho, BeginExp L) = ( eval(rho, hd L); eval(rho, BeginExp (tl L)) )

    | eval (rho, ApExp (exp, argList) ) =
        ( case eval(rho, exp) of
            Closure ((vars, body), env) => ( if (List.length vars) <> (List.length argList) then
                                                raise RuntimeError ("Number of args needs doesn't match number needed for closure.") 
                                            else 
                                                let
                                                    val evalArgs = map (fn (e) => eval(rho, e)) argList
                                                    val newEnv = List.tabulate( (List.length vars), (fn (i) => (List.nth(vars, i), List.nth(evalArgs, i))) )
                                                in
                                                    eval( (ref newEnv)::env , body ) 
                                                end )
            | BinaryPrimOp (s, f) =>  (if 2 <> (List.length argList) then
                                                raise RuntimeError ("Binary operator expects 2 arguments.") 
                                            else 
                                                let
                                                    val evalArgs = map (fn (e) => eval(rho, e)) argList
                                                in
                                                    f(hd evalArgs, List.last evalArgs)
                                                end )
            | UnaryPrimOp (s, f) =>  (if 1 <> (List.length argList) then
                                                raise RuntimeError ("Unary operator expects 1 argument.") 
                                            else 
                                                let
                                                    val evalArg = eval(rho, hd argList)
                                                in
                                                    f(evalArg)
                                                end )
            | _ => raise RuntimeError ("Function not implemented: " ) )


    | eval (rho, exp) = (print (expressionToRepr exp ^ "\n"); NilSxp)
