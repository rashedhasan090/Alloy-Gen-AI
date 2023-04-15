sig List  {
    header: set Node
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
    no This.header || one n: This.header.*link | n in n.link
}

pred Sorted(This: List) {
    all n: This.header.*link | n.link = Node => n.elem <= n.link.elem
}

pred RepOk(This: List) {
    Loop[This]
    Sorted[This]
}

pred Count(This: List, x: Int, result: Int) {
    RepOk[This]
    #{n: This.header.*link | n.elem = x} = result
}

abstract sig Boolean {}
one sig True, False extends Boolean {}

pred Contains(This: List, x: Int, result: Boolean) {
    RepOk[This]
    // Fixed bug here
    (#{n: This.header.*link | n.elem = x} > 0) => True = result
}

fact { some Node }

assert repair_assert_1{
    all l:List | all x:Int | all res:Boolean |
        Contains[l, x, res] <=>
        {
            RepOk[l]
            (#{n: l.header.*link | n.elem = x} > 0) <=> True = res
        }
}
check repair_assert_1

pred repair_pred_1{
    all l:List | all x:Int | all res:Boolean |
        Contains[l, x, res] <=>
        {
            RepOk[l]
            (#{n: l.header.*link | n.elem = x} > 0) <=> True = res
        }
}
run repair_pred_1

fact IGNORE {
  one List
  List.header.*link = Node
}