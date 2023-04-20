The bug in this specification is in the "Sorted" predicate. The "n.^left" and "n.^right" expressions should be replaced with "n.left.*(left + right)" and "n.right.*(left + right)", respectively. 

The correct "Sorted" predicate should look like this: 

pred Sorted() {
  all n:Node {
    // All elements in the n's left subtree are smaller than the n's elem.
    all n2:n.left.*(left + right) | n2.elem < n.elem
    // All elements in the n's right subtree are bigger than the n's elem.
    all n2:n.right.*(left + right) | n2.elem > n.elem
  }
}