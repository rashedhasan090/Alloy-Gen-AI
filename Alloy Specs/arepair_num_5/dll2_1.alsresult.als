one sig DLL {
  header: lone Node
}

sig Node {
  pre, nxt: lone Node,
  elem: Int
}

fact Reachable {
  Node = DLL.header.*nxt
}

fact Acyclic {
  all n: Node | n !in n.^nxt
}

pred UniqueElem() {
  all n1, n2: Node {
    n1 != n2 => n1.elem != n2.elem
  }
}

pred Sorted() {
  all n: Node | n.nxt.elem >= n.elem
}

pred ConsistentPreAndNxt() {
  all n1, n2: Node {
    n1.nxt = n2 => n2.pre = n1 and n2.nxt != n1
    n1.pre = n2 => n1.nxt = n2 and n1.pre != n2
  }
}

pred RepOk() {
  UniqueElem
  Sorted
  ConsistentPreAndNxt
}

assert repair_assert_1{
    Sorted <=>
    all n : Node | some n.nxt => n.elem <= n.nxt.elem
}

check repair_assert_1

pred repair_pred_1{
    Sorted <=>
    all n : Node | some n.nxt => n.elem <= n.nxt.elem
}

run repair_pred_1