The bug in the specification is in the predicate ConsistentPreAndNxt(). The fix is to add "nxt = ~pre". 
The corrected predicate should look like this:

pred ConsistentPreAndNxt() {
  all n1, n2: Node {
    (n1.nxt = n2) implies n2.pre = n1 and n1.nxt = n2
    (n2.nxt = n1) implies n1.pre = n2 and n2.nxt = n1
    // Fix: add "nxt = ~pre".
    nxt = ~pre
  }
}