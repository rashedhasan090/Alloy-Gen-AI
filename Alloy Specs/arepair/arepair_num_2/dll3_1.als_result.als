The bug is in the ConsistentPreAndNxt predicate, which is empty. It should define the consistency between pre and nxt links:

pred ConsistentPreAndNxt() {
  all n1, n2: Node |
    (n1.nxt = n2) implies n2.pre = n1 and n1.nxt = n2
}

The fixed specification satisfies the assertions.