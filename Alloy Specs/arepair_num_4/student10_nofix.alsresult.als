There is an overconstraint in the 'Sorted' predicate. The constraint 'all n: This.header.*link | n.elem <= n.link.elem' should be modified to 'all n: This.header.*link - last | n.elem <= n.link.elem', to exclude the last element in the list, which has no link. The corrected 'Sorted' predicate is as follows:

pred Sorted(This: List) {
    all n: This.header.*link - last | n.elem <= n.link.elem
}