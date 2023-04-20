The bug is in the Sorted predicate. The predicate should check if the nxt of a node is undefined or not, before comparing its element with the element of the nxt node. If a node has no nxt node defined, then it should be considered sorted. Here's the corrected Sorted predicate:

pred Sorted() {
  // The list is sorted in ascending order (<=) along nxt.
  all n : Node | n.nxt.elem >= n.elem
}