The bug in the specification is in the fact "Reachable". The correct fact should be:

fact Reachable {
   BinaryTree.root in Node
   all n:Node | n in BinaryTree.root.*(left + right)
}

This correctly states that the root of the binary tree is a node and that all nodes are reachable from the root through zero or more traversals of left and right.