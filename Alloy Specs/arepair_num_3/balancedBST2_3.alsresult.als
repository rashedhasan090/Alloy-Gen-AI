The bug in the specification is in Part (b) of the specification, in the Sorted predicate. The quantification of nl and nr should include n.left and n.right, respectively, in order to properly check the sorted order of the elements in the left and right subtrees.

The corrected Sorted predicate is:

pred Sorted() {
  all n: Node {
    // All elements in the n's left subtree are smaller than the n's elem.
    all nl: n.left.*(left + right) + n.left | nl.elem < n.elem
    // All elements in the n's right subtree are bigger than the n's elem.
    all nr: n.right.*(left + right) + n.right | nr.elem > n.elem
  }
}