The bug is in the Loop predicate where the condition should be "no This.header.link" instead of "no This.header.link || one n: This.header.*link | n.link = n". 

The corrected specification is:

sig List {
    header : set Node
}

sig Node {
    link: set Node,
    elem: set Int
}

fact CardinalityConstraints {
    all l: List | lone l.header
    all n: Node | lone n.link
    all n: Node | one n.elem
}

pred Loop(This: List) {
    no This.header.link
}

pred Sorted(This: List) {
    all n: This.header.*link | one n.link || n.elem <= n.link.elem
}

assert repair_assert_2 {
    all l: List | Loop[l] <=> {
    no l.header or one n: l.header.*link | n = n.link
}}

check repair_assert_2

pred repair_pred_2 {
    all l: List | Loop[l] <=> {
    no l.header.link or one n: l.header.*link | n = n.link
}}

run repair_pred_2

pred RepOk(This: List) {
    Loop[This]
    Sorted[This]
}

pred Count(This: List, x: Int, result: Int) {
    RepOk[This]
    result = #{n: Node | n in This.header.*link && n.elem = x}
}

abstract sig Boolean {}
one sig True, False extends Boolean {}

pred Contains(This: List, x: Int, result: Boolean) {
    RepOk[This]
    {some n: This.header.*link | n.elem = x} => result = True else result = False
}

fact IGNORE {
  one List
  List.header.*link = Node
}