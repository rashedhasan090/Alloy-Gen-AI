The bug in the specification is in the "pred Sorted" predicate. The predicate should only compare the elements of nodes that are linked together (i.e., n.link.elem) rather than all nodes in the list (i.e., n.elem < n.link.elem should be n.link.elem > n.elem). 

The corrected "pred Sorted" predicate is:

pred Sorted(This: List) {
    all n : This.header.*link | no n.link or n.elem < n.link.elem
}