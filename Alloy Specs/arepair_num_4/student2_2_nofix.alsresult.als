The bug in this specification is in the Sorted predicate. The comparison operator should be "<=" instead of ">=". The corrected predicate is:

pred Sorted ( This : List ) {
    all n: This.header.*link | some n.link =>  n.elem <= n.link.elem
}