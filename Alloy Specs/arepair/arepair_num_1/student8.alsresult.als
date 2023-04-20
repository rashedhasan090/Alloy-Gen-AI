The overconstraint in the "Sorted" predicate occurs because it requires that all nodes have a link, which is not necessary for a valid sorted list. The predicate should instead check that if a node has a link, then its element is less than or equal to the element of the linked node. 

Here's the corrected "Sorted" predicate:

pred Sorted(This: List) {
  all n:Node | some n.link => n.elem <= n.link.elem
}