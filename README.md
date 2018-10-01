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
