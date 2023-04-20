The bug is in the fact "CardinalityConstraints". The constraint "all n: Node | one n.elem" states that each node should have exactly one element, but this is not necessary for every use case of a linked list. This constraint should be removed. 

Corrected Alloy specification:

sig List {
    header: set Node
}

sig Node {
    link: set Node,
    elem: set Int
}


fact CardinalityConstraints {
    List.header.*link = Node
    all l: List | lone l.header
    all n: Node | lone n.link
}

pred Loop(This: List) {
    one n:This.header.*link | n in n.^link
}

pred Sorted(This: List) {
    all n : This.header.*link | n.elem <= n.link.elem
}

assert repair_assert_2 {
    all l: List | Loop[l] <=> {
    no l.header or one n: l.header.*link | n = n.link
}}

check repair_assert_2

pred repair_pred_2 {
    all l: List | Loop[l] <=> {
    no l.header or one n: l.header.*link | n = n.link
}}

run repair_pred_2

pred RepOk(This: List){
    Loop[This]
    Sorted[This]
}

pred Count(This: List, x: Int, result: Int) {
    RepOk[This]
    result = #{n: This.header.*link | n.elem = x}
}

abstract sig Boolean {}
one sig True, False extends Boolean {}

pred Contains(This: List, x: Int, result: Boolean) {
     RepOk[This]
     x !in This.header.*link.elem <=> result = False
}

fact IGNORE {
  one List
  List.header.*link = Node
}