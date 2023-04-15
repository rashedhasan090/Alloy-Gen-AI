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
    // n not in n.^pre
    // no n.pre & n.nxt
    // all n:Node|no n.header or some dl:
  }
}

pred UniqueElem() {
  // Unique nodes contain unique elements.
  // Bug:
  all n:Node | n.pre.elem & n.nxt.elem = none
}

pred Sorted() {
  // The list is sorted in ascending order (<=) along link.
  all n: DLL.header.*nxt | some n.nxt implies n.elem <= n.nxt.elem
}

pred ConsistentPreAndNxt() {
  //all n1, n2: Node {
  // For any node n1 and n2, if n1.link = n2, then n2.prev = n1; and vice versa.
  //{some n1.link=n2}  implies n2.prev = n1 else n2.link = n1
  //}
  // Bug:
}

pred RepOk() {
  UniqueElem
  Sorted
  ConsistentPreAndNxt
}

//run RepOk for 3

assert repair_assert_3{
ConsistentPreAndNxt <=>
all n1, n2: Node | n1.nxt = n2 <=> n2.pre = n1
}
check repair_assert_3

pred repair_pred_3{
ConsistentPreAndNxt <=>
all n1, n2: Node | n1.nxt = n2 <=> n2.pre = n1
}
run repair_pred_3