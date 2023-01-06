
third([X, Y, Z | TAIL], Z).

del3([X, Y, Z | TAIL], [X, Y | TAIL]).

isDuped([]).
isDuped([X, X | TAIL]) :- isDuped(TAIL).

evenSize([]).
evenSize([_, _ | TAIL]) :- evenSize(TAIL).
