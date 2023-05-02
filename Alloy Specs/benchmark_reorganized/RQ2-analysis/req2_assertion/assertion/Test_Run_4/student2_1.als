sig List {
    header: set Node
}

sig Node {
    link: set Node,
    elem: set Int
}

// Fixed
fact CardinalityConstraints {
    all l : List | lone l.header
    all n : Node | lone n.link
    all n : Node | one n.elem
}

// Correct
pred Loop ( This : List ) {
    no This.header || one n : This.header.*link | n.^link = n.*link
}

// Fixed
pred Sorted ( This : List ) {
    all n: This.header.*link | no n.link || n.elem <= n.link.elem
}

assert repair_assert_1 {
    all l: List | Sorted[l] <=> { all n: l.header.*link | no n.link || (n.link.elem >= n.elem) }
}
check repair_assert_1

pred repair_pred_1 {
    all l: List | Sorted[l] <=> { all n: l.header.*link | no n.link || (n.link.elem >= n.elem) }
}
run repair_pred_1

pred RepOk ( This : List ) {
    Loop [This]
    Sorted [This]
}

// Correct
pred Count ( This : List , x : Int , result : Int ) {
    RepOk [This]
    result = #{ n:This.header.*link | n.elem = x }
}

abstract sig Boolean {}
one sig True , False extends Boolean {}

// Fixed
pred Contains ( This : List , x : Int , result : Boolean ) {
    RepOk [ This ]
    (x in This.header.*link.elem => result=True ) && (x !in This.header.*link.elem => result=False)
}

fact IGNORE {
  one List
  List.header.*link = Node
}