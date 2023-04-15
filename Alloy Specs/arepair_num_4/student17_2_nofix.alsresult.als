The bug in the specification is in the Sorted predicate. The predicate should use the "<" operator instead of "<=" operator in the comparison of the elements of the nodes. The fixed Sorted predicate is given below:

pred Sorted(This: List) {
    all n: This.header.*link | n.link = none or n.elem < n.link.elem
}