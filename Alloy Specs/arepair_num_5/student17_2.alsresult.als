sig List {
    header: lone Node // Fix: Changed set to lone
}

sig Node {
    link: set Node,
    elem: set Int
}

fact CardinalityConstraints {
    List.header.*link = Node
    all l: List | lone l.header
    all n: Node | lone n.link
    all n: Node | one n.elem
}

pred Loop(This: List) {
    one n: This.header.*link | n.link = n
}

pred Sorted(This: List) {
    all n: This.header.*link | 
        no n.link or n.elem <= n.link.elem // Fix: Added check for n.link existence
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

pred Count(This: List, x: Int, result: Int) {
    RepOk[This]
    result = #{n: This.header.*link | n.elem = x}
}

abstract sig Boolean {}
one sig True, False extends Boolean {}

pred Contains(This: List, x: Int, result: Boolean) {
    RepOk[This]
    result = True <=> x in This.header.*link.elem
}

pred RepOk(This: List) {
    Loop[This]
    Sorted[This]
}

fact IGNORE {
  one List
  List.header.*link = Node
}