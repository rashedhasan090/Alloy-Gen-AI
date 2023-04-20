The bug in the specification is in the Sorted predicate. The link relation should be transitive, i.e., if n1 is linked to n2 and n2 is linked to n3, then n1 should also be linked to n3. Therefore, the correct Sorted predicate is:

// Corrected
pred Sorted(This: List) {
  all n1, n2, n3: Node | (n1 in This.header.*link and n2 in n1.link and n3 in n2.link) implies n1.elem <= n2.elem and n2.elem <= n3.elem
}

With this correction, the assertions should pass.