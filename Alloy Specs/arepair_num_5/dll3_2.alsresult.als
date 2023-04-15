one sig DLL {
  header: lone Node
}

sig Node {
  pre, nxt: lone Node,
  elem: Int
}

// All nodes are reachable from the header node.
fact Reachable {
  Node = DLL.header.*nxt
}

fact Acyclic {
  all n : Node {
    // The list has no directed cycle along nxt, i.e., no node is
    // reachable from itself following one or more traversals along nxt.
    n not in n.^nxt
    // Bug fixed: also ensure that there are no cycles in the pre link
    n not in n.^pre
    //ensure that pre and nxt are not the same
    no n.pre & n.nxt
  }
}

pred UniqueElem() {
  // Unique nodes contain unique elements.
  // Bug fixed: using and instead of &
  all n:Node | n.pre.elem = none and n.nxt.elem = none
}

pred Sorted() {
  // The list is sorted in ascending order (<=) along link.
  all n: DLL.header.*nxt | some n.nxt implies n.elem <= n.nxt.elem
}

pred ConsistentPreAndNxt() {
  // For any node n1 and n2, if n1.link = n2, then n2.prev = n1; and vice versa.
  all n1, n2: Node {
    (n1.nxt = n2) implies n2.pre = n1
    (n1.pre = n2) implies n2.nxt = n1
  }
}

pred RepOk() {
  UniqueElem
  Sorted
  ConsistentPreAndNxt
}

//run RepOk for 3
run RepOk for 3

assert repair_assert_2{
    UniqueElem <=>
        all n:Node | all n2:Node | n != n2 => n.elem != n2.elem
}
check repair_assert_2

pred repair_pred_2{
    UniqueElem <=>
        all n:Node | all n2:Node | n != n2 => n.elem != n2.elem
}
run repair_pred_2