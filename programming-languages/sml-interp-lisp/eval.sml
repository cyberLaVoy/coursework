exception RuntimeError of string

local
    val globals: (string * sxp) list ref = ref []
    val functions: (string * (string list) * expression) list ref = ref []
in
    fun globalGet key =
        let fun f [] = NONE
              | f ((k,v)::tail) = if k = key then SOME v else f tail
        in f (!globals) end

    fun globalSet key value =
        let fun f [] = [(key, value)]
              | f ((k,v)::tail) = if k = key then (k,value)::tail else (k,v)::f tail
        in globals := f (!globals) end

    fun functionGet name =
        let fun f [] = NONE
              | f ((def as (k,_,_))::tail) = if k = name then SOME def else f tail
        in f (!functions) end

    fun functionSet (def as (name, _, _)) =
        let fun f [] = [def]
              | f ((elt as (k,_,_))::tail) = if k = name then def::tail else elt::f tail
        in functions := f (!functions) end

    fun rhoGet [] _ = NONE
      | rhoGet ((key, value)::tail) name =
            if key = name then SOME value else rhoGet tail name

    fun rhoSet [] key value = [(key, value)]
      | rhoSet ((elt as (k, v)) :: tail) key value =
            if key = k then (key, value) :: tail else elt :: rhoSet tail key value

    fun rhoContains rho name =
        case rhoGet rho name of SOME _ => true | NONE => false
end


(* your code goes here *)
fun lists2pairs(L, M) =
    ( List.tabulate( (List.length L), (fn i => ( List.nth(L, i), List.nth(M, i) ) ) ) )

fun eval (rho, ValExp v) = (rho, v) 

    | eval (rho, VarExp name) = 
        ( case rhoGet rho name of
            SOME v => (rho, v)
          | NONE => ( case globalGet name of 
                        SOME v => (rho, v)
                      | NONE => raise RuntimeError ("Undefined variable: " ^ name) ) ) 

    | eval (rho, IfExp (cond, thenPart, elsePart) ) = 
        ( case eval(rho, cond) of
            (rho, NilSxp) => eval(rho, elsePart)
            | (rho, _) => eval(rho, thenPart) )

    | eval (rho, WhileExp (cond, body) ) =
        ( case eval(rho, cond) of
          (rho, NilSxp) => (rho, NilSxp)
        | (rho, _) => ( let val (rho, _) = eval(rho, body) 
                        in eval(rho, WhileExp (cond, body)) 
                        end )
        )

    | eval (rho, SetExp (name, exp)) = 
        let val (rho, v) = eval(rho, exp)
        in  if rhoContains rho name then
                (rhoSet rho name v, v) 
             else 
                let val _ = globalSet name v 
                in (rho, v) 
                end
        end

    | eval (rho, BeginExp [exp]) = eval(rho, exp) 
    | eval (rho, BeginExp L) = let val (rho, v) = eval(rho, hd L) in eval(rho, BeginExp (tl L)) end

    | eval (rho, BinaryBuiltinExp (name, left, right)) = 
        let val (rho, lv) = eval(rho, left)
            val (rho, rv) = eval(rho, right)
        in ( case (name, rho, lv, rv) of
             ("+", rho, NumSxp lv, NumSxp rv) => (rho, NumSxp (lv+rv))
            | ("-", rho, NumSxp lv, NumSxp rv) => (rho, NumSxp (lv-rv))
            | ("*", rho, NumSxp lv, NumSxp rv) => (rho, NumSxp (lv*rv))
            | ("/", rho, NumSxp lv, NumSxp rv) => (rho, NumSxp (lv div rv))
            | ("<", rho, NumSxp lv, NumSxp rv) => (rho, (if lv < rv then SymSxp "T" else NilSxp))
            | (">", rho, NumSxp lv, NumSxp rv) => (rho, (if lv > rv then SymSxp "T" else NilSxp))
            | ("=", rho, lv, rv) => ( case (lv, rv) of
                                      (NumSxp lv, NumSxp rv) => (rho, (if lv = rv then SymSxp "T" else NilSxp))
                                      | (SymSxp lv, SymSxp rv) => (rho, (if lv = rv then SymSxp "T" else NilSxp))
                                      | (NilSxp, NilSxp) => (rho, SymSxp "T")
                                      | (_, _) => (rho, NilSxp)
                                    )
            | ("cons", rho, lv, rv) => ( case (lv, rv) of 
                                         (lv, NumSxp rv) => raise RuntimeError ("Not a valid right hand expression.") 
                                         | (lv, SymSxp rv) => raise RuntimeError ("Not a valid right hand expression.") 
                                         | (lv, rv) => (rho, ListSxp (lv,rv)) )

            )
        end 

    | eval (rho, UnaryBuiltinExp (name, exp) ) = 
        let val (rho, v) = eval(rho, exp)
        in ( case (name, v) of
              ("print", v) => ( print ( (sxpToString v) ^ "\n" ); (rho, v) ) 
              | ("cdr", ListSxp (x, xs)) => (rho, xs)
              | ("car", ListSxp (x, xs)) => (rho, x)
              | ("null?", NilSxp) => (rho, SymSxp "T")
              | ("null?", _) => (rho, NilSxp)
              | ("symbol?", SymSxp v) => (rho, SymSxp "T")
              | ("symbol?", _) => (rho, NilSxp)
              | ("list?", ListSxp v) => (rho, SymSxp "T")
              | ("list?", _) => (rho, NilSxp)
              | ("number?", NumSxp v) => (rho, SymSxp "T")
              | ("number?", _) => (rho, NilSxp)
        )
        end

    | eval (rho, ApExp (name, argList) ) =
        ( case functionGet name of
            SOME (f, formals, body) => ( if (List.length formals) <> (List.length argList) then
                                            raise RuntimeError ("Number of args does not match function definition") 
                                         else 
                                            let
                                            val evalList = foldr (fn (exp, acc) => eval(rho, exp)::acc) [] argList
                                            val evalArgs = map (fn (_, a) => a) evalList
                                            val funEnv = lists2pairs(formals, evalArgs)
                                            val (_, v) = eval(funEnv, body)
                                            in ( rho , v) 
                                            end )
          | NONE => raise RuntimeError ("Function not implemented: " ^ name) )

    | eval (rho, exp) =
        (print (expressiontoRepr exp ^ "\n");
        (rho, NilSxp))