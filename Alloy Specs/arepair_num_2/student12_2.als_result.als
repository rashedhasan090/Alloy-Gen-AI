The bug is in the Contains predicate, where the result is not computed correctly. The correct fix is to use the "some" quantifier instead of the "all" quantifier.

Fixed Contains predicate:

pred Contains(This: List, x: Int, result: Boolean) {
    RepOk[This]
    result = (some n: This.header.*link | n.elem = x)
}