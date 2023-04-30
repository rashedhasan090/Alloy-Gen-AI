sig List {
    header: set Node
}

sig Node {
    link: set Node,
    elem: set Int
}

// Correct
fact CardinalityConstraints {
    all l: List | lone l.header
    all n: Node | lone n.link
    all n: Node | one n.elem
}

// Correct
pred Loop(This: List) {
    no n: Node - This.header | n = n.link
    one n:Node | n.link = This.header
}

fact allNodesBelongToOneList{
    all n: Node | one l: List | n in l.header.*link
}

// Fixed
pred Sorted(This: List) {
    all n: Node - This.header | n.elem <= (n.link - This.header).elem
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

pred RepOk(This: List) {
    Loop[This]
    Sorted[This]
}

// Correct
pred Count(This: List, x: Int, result: Int) {
    RepOk[This]
    result = #{n: Node |  n in This.header.*link && n.elem = x}
}

abstract sig Boolean {}
one sig True, False extends Boolean {}

// Correct
pred Contains(This: List, x: Int, result: Boolean) {
    RepOk[This]
    #{n: Node | n in This.header.*link && n.elem = x} > 0 => result = True else result = False
}

fact IGNORE {
  one List
  List.header.*link = Node
}