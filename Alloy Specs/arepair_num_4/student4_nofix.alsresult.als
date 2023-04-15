The bug in the specification is in the predicate Sorted. The comparison "n.elem <= n.link.elem" assumes that every node has a link, but this is not true for the last node in the list. Therefore, the predicate should consider nodes that have a link and nodes that do not have a link separately. 

Here is the corrected specification (changes are marked with comments):

sig List {
  header: set Node
}

sig Node {
  link: lone Node, // use "lone" instead of "set" to allow nodes without a link
  elem: set Int
}

fact CardinalityConstraints {
  all l:List | lone l.header
  all n:Node | lone n.link
  all n:Node | one n.elem
}

pred Loop(This: List) {
  no This.header || one n:This.header.^link | n = n.link
}

pred Sorted(This: List) {
  all n:(This.header.*link) | (no n.link) || (n.elem <= n.link.elem) // consider nodes without a link separately
}

assert repair_assert_1 {
    all l: List | Sorted[l] <=> { all n: l.header.*link | some n.link => n.elem <= n.link.elem }
}
check repair_assert_1

pred repair_pred_1 {
    all l: List | Sorted[l] <=> { all n: l.header.*link | some n.link => n.elem <= n.link.elem }
}
run repair_pred_1

pred RepOk(This: List) {
  Loop[This]
  Sorted[This]
}

pred Count(This: List, x: Int, result: Int) {
  RepOk[This]
  result = #{n: This.header.*link | n.elem = x}
}

abstract sig Boolean {}
one sig True, False extends Boolean{}

pred Contains(This: List, x: Int, result: Boolean) {
  RepOk[This]
  result = (x in This.header.*link.elem) // use parentheses instead of "=>" to avoid implicit "else"
}

fact IGNORE {
  one List
  List.header.*link = Node
}