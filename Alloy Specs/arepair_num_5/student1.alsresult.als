sig List {
    header: set Node
}
sig Node {
    link: set Node,
    elem: set Int // Changed to set instead of one
}

fact CardinalityConstraints {
    all l: List | lone l.header
    all n: Node | lone n.link
    all n: Node | one n.elem
}

pred Loop(This: List) {
    all n: Node | n in This.header.*link
    #Node=0  || some n: This.header.*link | n.link = n
}

pred Sorted(This: List) {
    all n: Node | no n.link or (some ln: n.link | n.elem <= ln.elem) // Fixed bug
}

pred RepOk(This: List) {
    Loop[This]
    Sorted[This]
}

pred Count(This: List, x: Int, result: Int) {
    RepOk[This]
    result = #{n:Node | n in This.header.*link && n.elem=x}
}

abstract sig Boolean {}
one sig True, False extends Boolean {}
pred Contains(This: List, x: Int, result: Boolean) {
    RepOk[This]
    result = {some {n :Node | n in This.header.*link && n.elem=x} => True else False}
}

fact IGNORE {
  one List
  List.header.*link = Node
}

assert repair_assert_1 {
    all l: List | { Sorted[l] <=> {
    all n: l.header.*link | some n.link => n.elem <= n.link.elem
    }
}}
check repair_assert_1

pred repair_pred_1 {
    all l: List | Sorted[l] <=> { all n: l.header.*link | some n.link => n.elem <= n.link.elem }
}
run repair_pred_1