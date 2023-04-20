The bug in the Loop predicate is that it only checks for the case where there is no link from the header node, but it should also check for the case where there is a link but the list does not form a loop. This can be fixed by adding an additional clause to the predicate:

// Fixed:
pred Loop(This: List) {
    no This.header.link || one n: This.header.*link | n.link = n
    all n: Node - This.header | no n.*link & This.header not in n.*link
}

The bug in the Sorted predicate is that it requires every node to have a link, which is not necessary for a valid list. This can be fixed by changing "all n: This.header.*link" to "all n: Node | n in This.header.*link":

// Fixed:
pred Sorted(This: List) {
    all n: Node | n in This.header.*link => one n.link && n.elem <= n.link.elem
}

The bug in the Count predicate is that it uses "||" instead of "&&" in the set comprehension. This can be fixed by changing "n in This.header.*link || n.elem = x" to "n in This.header.*link && n.elem = x":

// Fixed:
pred Count(This: List, x: Int, result: Int) {
    RepOk[This]
    result = #{n: Node | n in This.header.*link && n.elem = x}
}