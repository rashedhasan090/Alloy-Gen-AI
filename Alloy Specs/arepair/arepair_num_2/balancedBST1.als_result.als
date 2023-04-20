The bug is in the fact "Reachable" that defines the set of all reachable nodes in the binary tree. The correct definition is:

fact Reachable {
  Node = BinaryTree.root.*(left + right) + BinaryTree.root
}

The "+" operator is used to include also the root node in the set of reachable nodes. Without this correction, some of the assertions may fail because they assume that the root node is a member of the set of reachable nodes.