The bug in the specification is in the pred Contains. The condition {some n: l.header.*link | n.elem = x } => True = result is incorrectly written. The implication should be reversed as follows:

{some n: l.header.*link | n.elem = x } <= result = True

The fixed pred Contains should be:

pred Contains(This: List, x: Int, result: Boolean) {
    RepOk[This]
    {some n: This.header.*link | n.elem = x } <= result = True
}