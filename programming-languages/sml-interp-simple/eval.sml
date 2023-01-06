(* do not change any of this *)
exception RuntimeError of string

local
    val globals: (string * int) list ref = ref []
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
            (rho, 1) => eval(rho, thenPart)
            | (rho, 0) => eval(rho, elsePart) 
            | (rho, _) => raise RuntimeError ("Invalid condition evaluation.") )

    | eval (rho, WhileExp (cond, body) ) =
        ( case eval(rho, cond) of
          (rho, 0) => (rho, 0)
        | (rho, 1) => let val (rho, _) = eval(rho, body) in eval(rho, WhileExp (cond, body)) end 
        | (rho, _) => raise RuntimeError ("Invalid condition evaluation.") )

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
        in ( case name of
              "+" => (rho, lv+rv) 
            | "-" => (rho, lv-rv) 
            | "*" => (rho, lv*rv) 
            | "/" => (rho, lv div rv) 
            | "=" => (rho, if lv = rv then 1 else 0) 
            | ">" => (rho, if lv > rv then 1 else 0) 
            | "<" => (rho, if lv < rv then 1 else 0) 
            | _ => raise RuntimeError ("Undefined binary expression: " ^ name) )
        end 

    | eval (rho, UnaryBuiltinExp (name, exp) ) = 
        let val (rho, v) = eval(rho, exp)
        in ( case name of
            "print" => ( let val _ = print ( (Int.toString v) ^ "\n" )
                         in (rho, v)
                         end )
            | _ => raise RuntimeError ("Undefined unary expression: " ^ name) )
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
        (print (expressionToRepr exp ^ "\n");
        (rho, 0))
