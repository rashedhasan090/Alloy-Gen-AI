The bug in the specification is in the Sorted predicate. The predicate should check if a node n has a next node before comparing their elements. The correct Sorted predicate is:

pred Sorted() {
  // The list is sorted in ascending order (<=) along nxt.
  all n: Node | n.nxt = none or n.elem < n.nxt.elem
}

With this fix, all the assertions pass.