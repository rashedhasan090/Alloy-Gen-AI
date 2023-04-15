The bug in the Loop predicate is that it does not exclude nodes that belong to the list header. To fix this, modify the predicate as follows:

pred Loop(This: List) {
    no n: Node - This.header | n = (n - This.header).link
    one n:Node | n.link = This.header
}

The bug in the Sorted predicate is that it is not taking into account the fact that nodes in the list header can have elements smaller than their successor nodes. To fix this, modify the predicate as follows:

pred Sorted(This: List) {
    all n: Node - This.header | n.elem <= (n.link-This.header).elem
}

With these fixes, the specification satisfies all the assertions.