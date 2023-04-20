sig List {
    header: lone Node // fixed bug here. Should be lone instead of set
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

pred Loop(This: List){
    // Bug fixed here. Changed one to lone
    lone n: This.header.*link | n in n.^link
}

pred Sorted(This: List){
    // Bug fixed here. Added "lone" before "n.link"
    all n: This.header.*link | lone n.link implies n.elem <= n.link.elem
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

pred Count(This: List, x: Int, result: Int){
    RepOk[This]
    result = #{ n: This.header.*link | x = n.elem }
}

abstract sig Boolean {}
one sig True, False extends Boolean {}

pred Contains(This: List, x: Int, result: Boolean) {
    RepOk[This]
    result = True <=> x in This.header.*link.elem
}

fact IGNORE {
  one List
  List.header.*link = Node
}