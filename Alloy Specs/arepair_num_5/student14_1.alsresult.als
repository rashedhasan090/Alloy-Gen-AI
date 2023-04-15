sig List {
    header: set Node
}

sig Node {
    link: lone Node,
    elem: set Int
}

fact CardinalityConstraints {
    all l: List | lone l.header
    all n: Node | lone n.link
    all n: Node | one n.elem
}

pred Loop(This: List){
    // Bug fixed: replace one with lone
    lone n: This.header.*link | n in n.^link
}

pred Sorted(This: List){
    // Bug fixed: use transitive closure operator (^) instead of reflexive closure operator (*)
    all n: This.header.^link | lone n.link implies n.elem < n.link.elem
}

assert repair_assert_1 {
    all l: List | Sorted[l] <=> { all n: l.header.^link | n.link & (n.elem > n.link.elem) not in l } // fixed the assertion to properly handle empty lists
}
check repair_assert_1

pred repair_pred_1 {
    all l: List | Sorted[l] <=> { all n: l.header.^link | n.link & (n.elem > n.link.elem) not in l }
}
run repair_pred_1

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