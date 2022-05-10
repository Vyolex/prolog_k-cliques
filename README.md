# k-cliques problem in Prolog
Programming paradigms Prolog assignment

The purpose of this program is to solve the K-cliques problem in a undirected graph. The graph gets input as an adjacency matrix, because it is undirected, the matrix will be symmetrical. 

## Usage
The graph is defined and hardcoded in [main.pl](./src/main.pl). To change which graph is being tested, modify the hardcoded graph.

### K-cliques
Deterimines if there is a K-clique in the graph. 

```
    findKClique(k).
```

#### Method
To find if there is a K-clique in a graph, we generate each possible permutation of nodes of a given length (K) and check if there is one where all the nodes connect to eachother. If no such permutation exists, then there is no K-clique present in the graph.

##### Optimisations
- K values higher than node amount fail immediately.
- Unique permutations: no repeating numbers used in permutation generation.


### Max clique
Finds the maximum size clique present in the graph. 

```
    dumbFindLargest(0,X).
```
The first argument in the rule is the starting value. 

#### Method
To find the maximum clique size, we simply iteratively compute increasing K-clique computations, when it fails, we know the maximum clique is one below the current K value. This is because no K clique can exist without a K-1 clique existing, which means we do not need to search further to find bigger cliques after the first failure.



## Requirements
This program has been written for the [SWI-Prolog](https://www.swi-prolog.org/) interpreter and uses some of it's build in predicates. It has not been verified to work with other Prolog interpreters.

