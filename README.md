# k-cliques problem in Prolog
Programming paradigms prolog assignment

The purpose of this program is to solve the k-cliques problem for an adjacency matrix.



## Find k cliques in graph
To find if there is a k-clique in a graph, we generate each possible unique permutation of nodes of a given length and check if there is one where all the nodes connect to eachother.

```
    findKClique(k).
```

## Find largest clique in a graph
Iteratively run increasing k-clique tests to find the largest possible.

```
    dumbFindLargest(0,X).
```

