use_module(library(lists)).

/*
    Adjacency matrix graph
*/
mygraph(
    [[0,1,1,1,1,0,0],
    [1,0,1,1,0,0,1],
    [1,1,0,1,0,1,0],
    [1,1,1,0,0,1,0],
    [1,0,0,0,0,1,0],
    [0,0,1,1,1,0,0],
    [0,1,0,0,0,0,0]]).

/*
    Rule that finds k-clique in graph
*/
findKClique(K) :- 
    mygraph(L),
    listLength(L, N),
    Ns is N-1,
    numlist(0, Ns, Xs),
    uniquePermutation(K, Xs, Ls),
    % print(Ls),
    allConnected(Ls).


/*
    Rule that finds largest clique in graph
    modified while loop implementation from: https://stackoverflow.com/questions/22885622/how-can-i-simulate-a-while-loop-in-prolog-with-unchangeable-conditions
*/
dumbFindLargest(K, KFinal) :-
    (not(once(findKClique(K))) ->
         KFinal is K-1
    ;
         K1 is K+1,
         dumbFindLargest(K1, KFinal)
    ).



% -- Helper functions

/*
    code to generate all possible UNIQUE permutations with repetition
    modified all permutations from: https://stackoverflow.com/questions/43102965/prolog-how-to-create-all-possible-permutations-with-repetition-give-a-list-of-o
*/
eval([],_).
eval([H|T],Set):- member(H,Set), eval(T,Set), not(member(H, T)).
uniquePermutation(N, Set, L):- length(L,N), eval(L,Set).


/*
    Check if all nodes are connected
*/
allConnected([]).
allConnected([A|L]) :- isConnected(A, L), allConnected(L).

isConnected(_, []).
isConnected(A, [F|R]) :- isEdge(A, F), isConnected(A, R).

/*
    Gets length of list
*/
listLength([], 0).
listLength([_|Xs], L) :- listLength(Xs,N), L is N+1.


/*
    getIndex1D(Y, L, I)
    Put element at index Y for 1D array L in variable I 
*/
getIndex1D(_, [], _) :- false. 
getIndex1D(0, [I|_], I).
getIndex1D(Y, [_|L], I) :- NEW_Y is Y-1, getIndex1D(NEW_Y, L, I).

/*
    getIndex2D(X, Y, L, I)
    Put element at index X,Y for 2D array L in variable I 
*/
getIndex2D(_, _, [], _) :- false. 
getIndex2D(0, Y, [L|_], I) :- getIndex1D(Y, L, I).
getIndex2D(X, Y, [_|L], I) :- NEW_X is X-1, getIndex2D(NEW_X, Y, L, I).

/*
    Checks if input is 1
*/
isOne(1) :- true.
isOne(_) :- false.

/*
    Determines if there is an edge between node X and Y
*/
isEdge(X, Y) :- 
    mygraph(L),
    getIndex2D(X, Y, L, I),
    isOne(I).