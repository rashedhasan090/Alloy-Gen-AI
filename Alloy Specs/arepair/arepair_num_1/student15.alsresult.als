The bug in this specification is in the Sorted predicate. The predicate says that for all nodes in the list, the element of the node is less than the element of the node it links to. However, this overconstrains the problem, as there may be nodes with no link. Instead, the predicate should say that if a node has a link, then its element is less than or equal to the element of the linked node. The fix is to replace "n.elem < n.link.elem" with "some n.link => n.elem <= n.link.elem". 

The corrected Sorted predicate is:
pred Sorted(This: List) {
    all n : This.header.*link | some n.link => n.elem <= n.link.elem
}