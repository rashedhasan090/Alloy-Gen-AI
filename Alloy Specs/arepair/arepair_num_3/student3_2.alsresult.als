The bug is in the 'Sorted' predicate where the comparison should be '<=', not '<'. Therefore, the corrected 'Sorted' predicate is:

pred Sorted(This: List) {
    all n: Node | n.elem <= (n.link-This.header).elem
}