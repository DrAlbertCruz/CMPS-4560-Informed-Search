# CMPS-4560-Informed-Search
CMPS 4560: Best first search and A* in Prolog

# Introduction

## Requirements

* SWI Prolog
* The files in this repository:
```shell
$ git clone https://github.com/DrAlbertCruz/CMPS-4560-Informed-Search.git
$ cd CMPS-4560-Informed-Search
```

## Prerequisites

* Work through an example of the Romanian map distance travel problem in the book by hand
* Understand tree search
* Understand best-first search
* Understand A* search
* Sorting algorithms in Prolog

# Background

This lab assumes you understand the differences between best-first search (also called greedy best-first search) and A* search before coming in to lab. Essentially, the differences are as follows:

## Greedy best-first search

Greedy best first search is an informed search that, instead of measuring distance traveled, measures distance to the goal. This is the *heuristic*, which has been provided for you in `map.pl` with the `hdist(.)`. predicates:
```prolog
h(Node, Value) :- 
    hdist(Node, Value).
hdist(arad     ,366).
hdist(bucharest,  0).
```
`h(.)` is basically an alias for `hdist(.)`. Note that the heuristic cost for travel to Bucharest is 0, implying that this is the goal and that these heuristic costs will only work with Bucharest as the goal. Greedy best first search is like a depth-first search except that `fringe` is sorted based on heuristic cost and you must pop the least cost node.

## A*

Greedy best-first will return a suboptimal solution because it does not account for distance travelled. It also has a strong potential to get stuck in loops. Thus, a better formulation is to amend the cost to: `(cost) = (distance to goal) + (distance to root/start).`

Recall that tree search algorithms are essentially the same. They just vary based on how fringe is organized, and how something is popped. From this discussion, we need to amend our tree search to do the following:

1. Some predicate to store the heuristic (this is done)
1. An ability to sort the list of paths based on heuristic cost
1. ... From above, we need to create a sorting algorithm in Prolog

# Approach

This lab consists of two parts: (1) study a best-first search algorithm in Prolog, and (2) ammend it to be an A* search.

## Best-first search

Luckily you do not have to do your work from scratch. `bestfirst.pl` contains an implementation of best-first search. Bring up `swipl`:

```shell
$ swipl
```

Consult the given files:

```prolog
?- ['map.pl'].
true.
?- ['bestfirst.pl'].
true.
```

Then carry out a search from arad to bucharest. *Do not forget that identifiers starting with a capital letter are actually variables, do not accidentally type Arad as opposed to arad.*

```prolog
?- best_first([[arad]],bucharest,N,P).
3
5
5
N = [bucharest, fagaras, sibiu, arad],
P = 3 ;
```

This command should be similar to what we did with depth-first. On line 16, `wrq/1` outputs the length of the current queue to the CLI. It's definition is 67. This is why it outputs numbers before finally giving us the values of `N` and `P` that satisfy our sentence. Go ahead and hit continue (`;`) to see the rest of the possible solutions. You could insert some code to get the search to terminate on first goal, but it is not required.

Study this implementation of best first search. Note that the tree search hasn't really changed. Except that before the recursive call to itself it sorts the queue. You have been provided with a `sort_queue1/2` predicate which is a recursive search. Consider the following questions before moving forward:

1. What type of a search is this?
1. Based on `append/3` is this breadth-first or depth-first?

## A*

Now implement A* search. Recall from the text/lecture that the cost function in A* (values which we sort a node by) is defined by:
f = g + h
where f is the total estimated cost. g is the cost so far to reach the goal. h is the estimated distance to the goal. 
