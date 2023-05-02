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

fact Acyclic {
  all n : Node {
    n !in n.^left and n !in n.^right // fix
    lone n.(left + right)            // fix
    no n.left & n.right
  }
}

pred Sorted() {
  all n: Node {
    some n.left => all child : n.left.*(left+right) | n.elem > child.elem
    some n.right => all child : n.right.*(left+right) | n.elem < child.elem
  }
}

pred HasAtMostOneChild(n: Node) {
  !(some n.left and some n.right)   // fix
}

fun Depth(n: Node): one Int {
  #(n.^~(left + right))             // fix
}

pred Balanced() {
  all n1, n2: Node {
    (HasAtMostOneChild[n1] and HasAtMostOneChild [n2]) => (minus[Depth[n1], Depth[n2]] <= 1 and minus[Depth[n1], Depth[n2]] >= -1)
  }
}

assert repair_assert_1{
  all n : Node | some n => Depth[n] = #(n.*~(left+right))
}
check repair_assert_1

pred repair_pred_1{
  all n : Node | some n => Depth[n] = #(n.*~(left+right))
}
run repair_pred_1