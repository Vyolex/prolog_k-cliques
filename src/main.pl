use_module(library(lists)).

/*
    Adjacency matrix graph
    Edit matrix to compute for different graphs.
*/
mygraph(
    [[0,1,1,1,1,0,0],
    [1,0,1,1,0,0,1],
    [1,1,0,1,0,1,0],
    [1,1,1,0,0,1,0],
    [1,0,0,0,0,1,0],
    [0,0,1,1,1,0,0],
    [0,1,0,0,0,0,0]]
    ).

/*
    Rule that finds k-clique in graph
*/
findKClique(K) :- 
    mygraph(L),                         % Load graph in L
    listLength(L, N),                   % Compute length of graph (#nodes) and store in N
    (
        K > N -> false                  % Check if K is larger than N (#nodes), if so return false (no cliques can exist with more nodes than there are)
    ;
        Ns is N-1,                      % Reduce N with one, because we index starting at 0
        numlist(0, Ns, Xs),             % Generate a list containing every number ranging from 0 to N-1
        uniquePermutation(K, Xs, Ls),   % Generate all unique permutations of size N from the previously generated list
        allConnected(Ls)                % Check if all nodes in permutation are connected
    ).
    


/*
    Rule that finds largest clique in graph
    modified while loop implementation from: https://stackoverflow.com/questions/22885622/how-can-i-simulate-a-while-loop-in-prolog-with-unchangeable-conditions
*/
dumbFindLargest(K, KFinal) :-
    (
        not(once(findKClique(K))) -> 
        KFinal is K-1                   % Check if there isn't a K-clique present, if so return K-1 as KFinal value
    ;
        K1 is K+1,                      % Increment K with one
        dumbFindLargest(K1, KFinal)     % Loop with increased K value
    ).



% -- Helper functions

/*
    code to generate all possible UNIQUE permutations with repetition
    modified all permutations from: https://stackoverflow.com/questions/43102965/prolog-how-to-create-all-possible-permutations-with-repetition-give-a-list-of-o
*/
uniquePermutation(N, Set, L):- 
    length(L,N),        % Make sure the returned permutation list is of size N
    eval(L,Set).        % Construct permutation

eval([],_).             % Start of recursive call
eval([H|T],Set):- 
    member(H,Set),      % Choose H as a member of the set of allowed values
    eval(T,Set),        % Recursively call function for the T(ail), making sure all values in tail are also in the allowed set
    not(member(H, T)).  % Check that H is not a value already present in T, make sure there are only unique values in the permutation


/*
    Check if all nodes are connected
*/
allConnected([]).       % Start of recursive call
allConnected([A|L]) :- 
    isConnected(A, L),  % Check if A is connected to all elements in L (tail)
    allConnected(L).    % Recursively call check for L

isConnected(_, []).     % Start of recursive call
isConnected(A, [F|R]) :- 
    isEdge(A, F),       % Checks if there is an edge between node A and F
    isConnected(A, R).  % Recursively call check for R


/*
    Gets length of list
*/
listLength([], 0).      % Start of recursive call
listLength([_|Xs], L) :- 
    listLength(Xs,N),   % Iteratively loop over list to get length (keeps going until there is no more head)
    L is N+1.           % Add one to previous length value


/*
    getIndex1D(Y, L, I)
    Put element at index Y for 1D array L in variable I 
*/
getIndex1D(_, [], _) :- false.  % Out of bounds check
getIndex1D(0, [I|_], I).        % Start of recursive call, return current head (found index)
getIndex1D(Y, [_|L], I) :- 
    NEW_Y is Y-1,               % Decrement Y value by one
    getIndex1D(NEW_Y, L, I).    % Loop over list until Y value is 0


/*
    getIndex2D(X, Y, L, I)
    Put element at index X,Y for 2D array L in variable I 
*/
getIndex2D(_, _, [], _) :- false.   % Out of bounds check
getIndex2D(0, Y, [L|_], I) :- 
    getIndex1D(Y, L, I).            % Found X index, look for Y
getIndex2D(X, Y, [_|L], I) :- 
    NEW_X is X-1,                   % Decrement X value by one
    getIndex2D(NEW_X, Y, L, I).     % Loop over list until X value is 0


/*
    Checks if input is 1
*/
isOne(1) :- true.
isOne(_) :- false.


/*
    Determines if there is an edge between node X and Y
*/
isEdge(X, Y) :- 
    mygraph(L),                 % Loads graph in L
    getIndex2D(X, Y, L, I),     % Find indexed value
    isOne(I).                   % Checks if there is an edge between the two