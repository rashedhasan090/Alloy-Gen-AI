The bug in this specification is in the "pred Contains" predicate. The condition should be "some n: This.header.*link | n.elem = x" instead of "all n: This.header.*link | n.elem = x". The corrected predicate is as follows:

pred Contains(This: List, x: Int, result: Boolean) {
    some n: This.header.*link | n.elem = x => result = True else result = False
}