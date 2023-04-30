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
  all n : Node | n !in n.^nxt
}

pred UniqueElem() {
  all n1, n2 : Node | n1 != n2 => n1.elem != n2.elem
}

pred Sorted() {
  all n : Node | n.nxt = null or n.elem <= n.nxt.elem
}

pred ConsistentPreAndNxt() {
  all n1, n2 : Node | n1 != n2 =>{
    n1.nxt = n2 <=> n2.pre = n1
  }
}

pred RepOk() {
  UniqueElem
  Sorted
  ConsistentPreAndNxt
}

run RepOk for 5

assert repair_assert_2{
  ConsistentPreAndNxt <=>
  all n1, n2: Node | n1.nxt = n2 <=> n2.pre = n1
}

check repair_assert_2

pred repair_pred_2{
  ConsistentPreAndNxt <=>
  all n1, n2: Node | n1.nxt = n2 <=> n2.pre = n1
}

run repair_pred_2