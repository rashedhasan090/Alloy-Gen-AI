sig List {
    header: lone Node // Fixed: header should be a lone Node to ensure there is exactly one header node
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
    all n: Node | n in This.header.*link
    no This.header || one n: This.header.*link | n in n.^link
}

pred Sorted(This: List) {
    all n1, n2: This.header.*link | (n1.link = n2 => n1.elem <= n2.elem) // Fixed: The comparison should be between n1.elem and n2.elem, not n.link.elem
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
    result = #{n:This.header.*link | n.elem = x}
}

abstract sig Boolean {}
one sig True, False extends Boolean {}

pred Contains (This: List, x: Int, result: Boolean) {
    RepOk[This]
    #{n: This.header.*link | x in n.elem} != 0 => result = True
    #{n: This.header.*link | x in n.elem} = 0 => result = False
}

fact IGNORE {
  one List
  List.header.*link = Node
}