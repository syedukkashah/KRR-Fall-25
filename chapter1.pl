parent(pam, bob).
parent(tom, bob).
parent(tom, liz).
parent(bob, ann).
parent(bob, pat).
parent(pat, jim).

% unary relations
% binary relation like parent defines relation between pairs of objects
% unary relations are used to declare simple yes/no properties 
% alt binary relation -> sex(pam, feminine)

female(pam).
female(liz).
female(pat).
female(ann).
male(jim).
male(tom).
male(bob).

offspring(Y,X):-parent(X,Y).

mother(X,Y):-female(X), parent(X,Y).

grandparent(X,Z):-parent(X,Y), parent(Y,Z).
sister(X,Y):- offspring(Y,Z), offspring(X,Z), female(X).

%everyone who has a child is happy
happy(X):- parent(X,Y).

%For all X, if X has a child who has a sister then X has two children
has_two_children(X):- parent(X,Y), sister(Y,Z).

%define grandchild relation using the parent relation
grandchild(X,Y):-parent(Y,Z), parent(Z,X).

%define aunt in terms of parent and sister
aunt(X,Y):- parent(Z,Y), sister(X,Z).

% limitation (predecessors returned up to a certain depth)

predecessor(X,Z):-parent(X,Z).

% recursive definitions
predecessor(X,Z):- parent(X,Y), predecessor(Y,Z).

fallible(X) :- man(X).
man(socrates).
