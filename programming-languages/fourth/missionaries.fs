create validStates 000 , 100 , 200 , 300 , 110 , 220 , 030 , 130 , 230 , 330 , 001 , 101 , 201 , 301 , 111 , 221 , 031 , 131 , 231 , 331 ,

variable usedStates 20 cells allot
usedStates 20 cells 0 fill 

variable cStack 18 cells allot 
variable bStack 18 cells allot 

variable cStackLen
0 cStackLen !

variable bStackLen
0 bStackLen !

: 2pow ( n -- 2^n ) 
    1 swap
    0 ?do 2 * loop ;

: 3dup ( x y z -- x y z x y z )  
    3 0 ?do 2 pick loop ;
: 3drop ( x y z -- ) drop drop drop ;

\ near: true - 1 false - 0
\ missionarries: 1 - 10, 2 - 20, 3 - 30
\ cannibals: 1 - 100, 2 - 200, 3 - 300
: pack ( near m c -- packedstate ) 
    100 *
    swap 10 * +
    + ;
: unpack ( packed -- near m c )
    dup 10 mod    \ cmn near
    swap over     \ near cmn near
    -             \ near cm0 
    dup           \ near cm0 cm0
    100 mod 10 /  \ near cm0 m 
    swap over     \ near m cm0 m
    10 * -        \ near m c00
    100 /         \ near m c
    ;

: printstate ( side m c -- ) 
    2 pick 0 = if ." [ near " else ." [  far " then 
    1 pick . 0 pick .
    ." ]" drop drop drop cr ;

\ push the starting state onto the stack
: startstate ( -- near m c ) 0 3 3 ;

\ test if the state on the stack is the goal state
: isgoal ( packed -- bool ) 
    001 = if -1 else 0 then ;

\ test if the state on the stack is valid and legal
: isvalid ( packed -- bool ) 
    0 tuck drop
    20 0 do 
        i cells validStates + @ 
        over = if nip -1 tuck drop then loop
    drop ;

\ test if n is in the used set
: isused ( packed -- bool ) 
    0 tuck drop                            \ 0 packed
    20 0 do                                \ 0 packed 
        i cells validStates + @            \ 0 packed validStates[i]
        over = if                          \ 0 packed 
                i cells usedStates + @ if  \ 0 packed 
                        nip -1 tuck drop   \ packed -1  
                                      then
               then 
        loop drop ;
: addused ( packed -- )
    20 0 do                                \ packed 
        i cells validStates + @            \ packed validStates[i]
        over = if                          \ packed 
                -1 usedStates i cells + ! 
               then 
        loop drop ;


\ push a value on the candidate stack
: pushcandidate ( n -- ) 
    cStack cStackLen @ cells + !
    cStackLen @ 1 + cStackLen !
     ;

\ pop a value off the candidate stack
: popcandidate ( -- n )
    cStackLen @ 1 - cStackLen !
    cStackLen @ cells cStack + @
     ;


\ push a value on the bread crumb trail stack
: pushcrumb ( n -- )
    bStack bStackLen @ cells + !
    bStackLen @ 1 + bStackLen !
     ;

\ pop a value off the bread crumb trail stack
: popcrumb ( -- n ) 
    bStackLen @ 1 - bStackLen !
    bStackLen @ cells bStack + @
     ;


\ print the contents of the candidate stack in order
: printcandidates ( -- ) 
    cr
    ." candidates:" cr
    cStackLen @ 0 ?do i cells cStack + @ unpack printstate loop 
    ;

\ print the contents of the bread crumb trail in order
: printcrumbs ( -- ) 
    bStackLen @ 0 ?do i cells bStack + @ unpack printstate loop
    ;

\ add a state to the candidate stack if it is valid and new
\ report on the outcome: invalid, repeat, or fresh
: addcandidate ( near m c -- ) 
    \ handle negative m or c cases
    dup 0 < if ." invalid " printstate exit then
    over 0 < if ." invalid " printstate exit then

    pack dup dup
    isvalid if 
            else 
                drop 
                ." invalid " unpack printstate exit 
            then
    isused if 
                ." repeat  " unpack printstate exit 
           else 
                dup addused
                dup 
                ." fresh   " unpack printstate
                pushcandidate 
           then 
     ;

: successorsNear
    unpack
    3dup 1 - addcandidate
    3dup 2 - addcandidate
    3dup 1 - swap 1 - swap addcandidate
    3dup swap 1 - swap addcandidate
    3dup swap 2 - swap addcandidate
    pack drop
    cStackLen @ swap -
    ;   
: successorsFar
    unpack
    3dup 1 + addcandidate
    3dup 2 + addcandidate
    3dup 1 + swap 1 + swap addcandidate
    3dup swap 1 + swap addcandidate
    3dup swap 2 + swap addcandidate
    pack drop
    cStackLen @ swap -
    ;
\ find all successor candidates for the given state, push them on stack
\ leaves the number of states added on the stack
: successors ( prevcStackLen near m c -- n )
    2 pick 1 = 
    if 
        pack 1 - successorsFar
    else 
        pack 1 + successorsNear
    then
    ;


\ find the solution from position at top of candidate stack
: findsolution ( -- ) 
    printcandidates
    popcandidate
    dup pushcrumb
    dup isgoal if 
        cr ." solution found" cr
        ." --------------" cr
        printcrumbs
    else 
        cStackLen @ swap unpack 
        successors
        0 ?do recurse loop
    then
        ." backtracking" cr
        popcrumb drop
     ;

: main ( -- )
    startstate pack dup addused pushcandidate
    findsolution
     ;   

main
bye