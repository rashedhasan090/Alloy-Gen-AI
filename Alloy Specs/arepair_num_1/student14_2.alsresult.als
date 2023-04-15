The bug in this specification is in the Sorted predicate. The constraint "all n: This.header.*link | n.elem <= n.link.elem" is too strong and doesn't allow for the possibility that a node might not have a link. This can be fixed by replacing it with "some n.link => n.elem <= n.link.elem", which allows for nodes without links.

Fixed predicate:

pred Sorted(This: List){
    all n: This.header.*link | some n.link => n.elem <= n.link.elem
}

With this fix, the specification should work as intended.