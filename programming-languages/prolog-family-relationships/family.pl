/* Family tree data */
/* Do not modify */

parent(shmi,vader).
parent(ruweee,padme).
parent(jobal,padme).
parent(vader,luke).
parent(vader,leia).
parent(padme,luke).
parent(padme,leia).
parent(luke,ben).
parent(mara,ben).
parent(leia,jaina).
parent(leia,jacen).
parent(leia,anakin).
parent(han,jaina).
parent(han,jacen).
parent(han,anakin).

/* Write your code here */

male(ruweee).
male(vader).
male(luke).
male(han).
male(ben).
male(jacen).
male(anakin).


female(shmi). 
female(jobal).
female(padme).
female(mara).
female(leia).
female(jaina).


mother(X, Y) :- female(X), parent(X, Y).
father(X, Y) :- male(X), parent(X, Y).

sibling(X, Y) :-  not(X = Y), father(Z, X), father(Z, Y), mother(W, X), mother(W, Y).
sister(X, Y) :- female(X), sibling(X, Y).
brother(X, Y) :- male(X), sibling(X, Y).

grandparent(X, Y) :- parent(X, Z), parent(Z, Y).
grandson(X, Y) :- male(X), grandparent(Y, X).
granddaughter(X, Y) :- female(X), grandparent(Y, X).

firstCousin(X, Y) :- not(X = Y), not(sibling(X, Y)), grandparent(Z, X), grandparent(Z, Y).

descendent(X, Y) :- parent(Y, X).
descendent(X, Y) :- parent(Z, X), descendent(Z, Y).