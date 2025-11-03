vertical(seg(point(X,Y), point(X, Y1))).

horizontal(seg(point(X,Y), point(X1, Y))).

/*
 (a) point( A, B) : point( 1, 2) returns A=1, B=2
 (b) point( A, B) : point( X, Y, Z) returns false 
 (c) plus( 2,2) = 4 returns false since we compare structure to number 
 (d) +( 2, D) : +( E,2) returns E = 2, D = 2
 (e) triangle( point(-1,0), P2, P3): triangle( P1, point(1,0), point(0,Y) 
        returns P1 = point(-1,0), P2 = point(1,0), P3 = point(0,Y)

 */


/*
Assume that a rectangle is represented by the term
 rectangle( Pl, P2, P3, P4) where the P's are the vertices of the rectangle
 positively ordered. Define the relation
 regular( R)
 which is true if R is a rectangle whose sides are vertical and horizontal
 */
 regular(R) :- rectangle(P1,P2,P3,P4), vertical(seg(P1, P2)), vertical(seg(P3, P4)), 
                horizontal(seg(P1,P4)), horizontal(seg(P2,P3)).


/* Consider the following program:
 f( 1, one).
 f( s(1), two).
 f( s(s(1)), three).
 f( s(s(s(X))), N) :- f( x, N).
 How will Prolog answer the following questions? Whenever several
 answers are possible, give at least two.
 (a) ?- f( s(1), A).
 (b) ?- f( s(s(1), two).
 (c) ?- f( s(s(s(s(s(s(1)))))), C).
 (d) ?- f( D, three).
 */

f(1, one).
f(s(1), two).
f(s(s(1)), three).
f(s(s(s(X))), N) :- f(X, N).

/*
The following program says that two people are relatives if
 (a) one is a predecessor of the other, or
 (b) they have a common predecessor, or
 (c) they have a common successor
 */
relatives(X,Y):-(predecessor(X,Y);predecessor(Y,X)); (predecessor(Z,X), predecessor(Z,Y)); (predecessor(X,Z), predecessor(Y,Z)).

/*
Rewrite the following program without using the semicolon notation.
 translate( Number, Word) :-
    Number = 1, Word = one;
    Number = 2, Word = two;
    Number = 3, Word = three.
 */

translate(Number, Word):- Number = 1, Word = one.
translate(Number, Word):- Number = 2, Word = two.
translate(Number, Word):- Number = 3, Word = three.

state(F,W,G,C)

valid_state(state(F,W,G,C)) :- 
    %goat and wolf alone 
    not((W==G, F\==G)),
    