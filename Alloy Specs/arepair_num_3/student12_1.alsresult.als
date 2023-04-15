The bug in the specification is in the "Contains" predicate, where the condition "{ all n: This.header.*link | n.elem = x } =>result = True" should be changed to "{ some n: This.header.*link | n.elem = x } =>result = True". The corrected version of the predicate is shown below:

pred Contains(This: List, x: Int, result: Boolean) {
    RepOk[This]
    { some n: This.header.*link | n.elem = x } =>result = True else result = False
}