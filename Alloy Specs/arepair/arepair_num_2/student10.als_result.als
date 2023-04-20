The bug in the specification is in the predicate Sorted. The quantification should be over pairs of nodes, since we need to compare each node with its successor in the list. So the fixed predicate is:

pred Sorted(This: List) {
    all n: This.header.*link |
        all m: n.link | n.elem <= m.elem
}

With this fix, the assertions pass.