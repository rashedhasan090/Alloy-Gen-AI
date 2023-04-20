The bug in the specification is in the Depth function. The cardinality operator (#) should be applied to the transitive closure of the union of the left and right child relations, not their converse (i.e., ~(left+right)). 
The corrected function is:

fun Depth(n: Node): one Int {
  // The number of nodes from the tree's root to n.
  #{n.*(left + right)}
}

With this correction, the provided assertions are satisfied.