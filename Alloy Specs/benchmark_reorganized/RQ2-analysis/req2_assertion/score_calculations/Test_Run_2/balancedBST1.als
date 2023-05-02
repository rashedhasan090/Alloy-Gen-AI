one sig BinaryTree {
  root: lone Node
}

sig Node {
  left, right: lone Node,
  elem: Int
}

// All nodes are in the tree.
fact Reachable {
  Node = BinaryTree.root.*(left + right)
}

// Part (a)
fact Acyclic {
  all n : Node {
    // There are no directed cycles, i.e., a node is not reachable
    // from itself along one or more traversals of left or right.
    n !in n.^left and n !in n.^right // fixed
    // A node cannot have more than one parent.
    lone n.~(left + right) // fixed
    // A node cannot have another node as both its left child and
    // right child.
    no n.left & n.right
  }
}

// Part (b)
pred Sorted() {
  all n: Node {
    // All elements in the n's left subtree are smaller than the n's elem.
    some n.left => all child : n.left.*(left+right) | child.elem < n.elem // fixed
    // All elements in the n's right subtree are bigger than the n's elem.
    some n.right => all child : n.right.*(left+right) | child.elem > n.elem // fixed
  }
}

// Part (c.1)
pred HasAtMostOneChild(n: Node) {
  // Node n has at most one child.
  !(n.left && n.right) // fixed
}

// Part (c.2)
fun Depth(n: Node): one Int {
  // The number of nodes from the tree's root to n.
  #(n.^~(left + right)) // fixed
}

// Part (c.3)
pred Balanced() {
  all n1, n2: Node {
    // If n1 has at most one child and n2 has at most one child,
    // then the depths of n1 and n2 differ by at most 1.
    // Hint: Be careful about the operator priority.
    (HasAtMostOneChild[n1] and HasAtMostOneChild [n2]) => ( abs[Depth[n1] - Depth[n2]] <= 1 ) // fixed
  }
}



assert repair_assert_1{
  all n : Node | some n => Depth[n] = #(n.^~(left+right))
}
check repair_assert_1

pred repair_pred_1{
  all n : Node | some n => Depth[n] = #(n.^~(left+right))
}
run repair_pred_1