sig List {
    header: lone Node                            // fix: use 'lone' instead of 'set' to ensure there is exactly one header
}

sig Node {
    link: set Node,
    elem: set Int
}

fact CardinalityConstraints {
    all l : List | lone l.header
    all n : Node | lone n.link
    all n : Node | one n.elem
}

pred Loop ( This : List ) {
    no This.header || one n : This.header.*link | n.^link = n.*link
}

pred Sorted ( This : List ) {
    all n: This.header.*link | no n.link || n.elem <= n.link.elem       // fix: add 'no n.link ||' to handle the case when there is no successor
}

assert repair_assert_1 {
    all l: List | Sorted[l] <=> { all n: l.header.*link | no n.link || (some n.link && n.elem <= n.link.elem) }     // fix: add 'no n.link ||' and '(some n.link &&' to handle the case when there is no successor
}
check repair_assert_1

pred repair_pred_1 {
    all l: List | Sorted[l] <=> { all n: l.header.*link | no n.link || (some n.link && n.elem <= n.link.elem) }
}
run repair_pred_1

pred RepOk ( This : List ) {
    Loop [This]
    Sorted [This]
}

pred Count ( This : List , x : Int , result : Int ) {
    RepOk [This]
    result = #{ n:This.header.*link | n.elem = x }
}

abstract sig Boolean {}
one sig True , False extends Boolean {}

pred Contains ( This : List , x : Int , result : Boolean ) {
    RepOk [ This ]
    ( x ! in This.header.*link.elem => result=False ) || result = True
}

fact IGNORE {
  one List
  List.header.*link = Node
}