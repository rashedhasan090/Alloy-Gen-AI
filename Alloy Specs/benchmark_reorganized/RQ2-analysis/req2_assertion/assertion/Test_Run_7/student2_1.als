sig List {
    header: set Node
}

sig Node {
    link: set Node,
    elem: set Int
}

// Correct
fact CardinalityConstraints {
    all l : List | lone l.header
    all n : Node | lone n.link
    all n : Node | one n.elem
}

// Corrected
pred Loop (This: List) {
    no This.header || one n: This.header.*link | n.^link = n.*link
}

// Corrected
pred Sorted (This: List) {
    all n1, n2: Node | n1.elem <= n2.elem && n2 in n1.link implies n1 in This.header.*link
}

assert repair_assert_1 {
    all l: List | Sorted[l] <=> { all n: l.header.*link | some n.link => n.elem <= n.link.elem }
}
check repair_assert_1

pred repair_pred_1 {
    all l: List | Sorted[l] <=> { all n: l.header.*link | some n.link => n.elem <= n.link.elem }
}
run repair_pred_1

pred RepOk (This: List) {
    Loop[This]
    Sorted[This]
}

// Correct
pred Count(This: List, x: Int, result: Int) {
    RepOk[This]
    result = #{n: This.header.*link | n.elem = x}
}

abstract sig Boolean {}
one sig True, False extends Boolean {}

// Corrected
pred Contains(This: List, x: Int, result: Boolean) {
    RepOk[This]
    result = (x in This.header.*link.elem) || False
}

fact IGNORE {
    one List
    List.header.*link = Node
}