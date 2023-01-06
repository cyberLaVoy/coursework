change(far, near).
change(near, far).

side(near).
side(far).

valid([M,C,Side]) :- 
    member(M,[0,1,2,3]), member(C,[0,1,2,3]), side(Side).

safe([X, X, _]).
safe([3, C, _]).
safe([0, C, _]).

onediff(X, Y, near) :- Y is X-1.
onediff(X, Y, far) :- Y is X+1.
twodiff(X, Y, near) :- Y is X-2.
twodiff(X, Y, far) :- Y is X+2.

move([M1, C, S1], onemissionary, [M2, C, S2]) :- change(S1, S2), onediff(M1, M2, S1).
move([M1, C, S1], twomissionaries, [M2, C, S2]) :- change(S1, S2), twodiff(M1, M2, S1).
move([M, C1, S1], onecannibal, [M, C2, S2]) :- change(S1, S2), onediff(C1, C2, S1).
move([M, C1, S1], twocannibals, [M, C2, S2]) :- change(S1, S2), twodiff(C1, C2, S1).
move([M1, C1, S1], oneofeach, [M2, C2, S2]) :- change(S1, S2), onediff(M1, M2, S1), onediff(C1, C2, S1).

solution([0,0,far], []).
solution(State, [Move|Rest]) :-
    valid(State),
    safe(State),
    move(State, Move, NextState),
    solution(NextState, Rest).