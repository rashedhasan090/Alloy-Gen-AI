The bug in the Loop predicate is that it assumes that a node in the list must exist which is reachable from itself through its links, which is not necessarily true. The corrected predicate should be:

pred Loop(This: List) {
    some l: This.header.*link | l in l.^link
}

The bug in the Sorted predicate is that it assumes that all nodes in the list have a link to another node, which is not necessarily true for the last node in the list. The corrected predicate should be:

pred Sorted(This: List) {
    all n : This.header.*link |
        lone n.link implies n.elem <= n.link.elem
}

After correcting these predicates, the assertions should hold.