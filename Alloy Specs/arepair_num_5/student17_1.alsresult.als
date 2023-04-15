sig List {
    header: set Node
}

sig Node {
    link: set Node,
    elem: set Int
}

// Correct.
fact CardinalityConstraints {
    List.header.*link = Node
    all l: List | lone l.header
    all n: Node | lone n.link
    all n: Node | one n.elem
}

// Fix: add "no This.header".
//pred Loop(This: List) {
pred Loop[this: List] {
    no this.header
    one n: this.*header.link | n.link = n
}

// Fix: replace "n.elem < n.link.elem" with "some n.link => n.elem <= n.link.elem".
pred Sorted[this: List] {
    all n: this.*header.link | some n.link => n.elem <= n.link.elem
}

assert repair_assert_1 {
    all l: List | Sorted[l] <=> { all n: l.header.*link | some n.link => n.elem <= n.link.elem }
}
check repair_assert_1

pred repair_pred_1 {
    all l: List | Sorted[l] <=> { all n: l.header.*link | some n.link => n.elem <= n.link.elem }
}
run repair_pred_1

// Correct
pred Count[this: List, x: Int, result: Int] {
    RepOk[this]
    result = #{n: this.*header.link | n.elem = x}
}

abstract sig Boolean {}
one sig True, False extends Boolean {}

// Correct
pred Contains[this: List, x: Int, result: Boolean] {
    RepOk[this]
    result = True <=> x in this.*header.link.elem
}

pred RepOk[this: List] {
    Loop[this]
    Sorted[this]
}

fact IGNORE {
  one List
  List.header.*link = Node
}