sig List {
    header: set Node
}

sig Node {
    link: lone Node, //changed to lone
    elem: set Int
}

// Correct
fact CardinalityConstraints {
    all l: List | #l.header <= 1
    all n: Node | #n.link <= 1
    all n: Node | #n.elem = 1
}

// Overconstraint. Should allow no l.header
// Underconstraint.  Should not allow link = n1 -> n2 + n2 -> n3 + n3 -> n1
// Overconstraint. Should allow link = n1 -> n2 + n2 -> n3 + n3 -> n3
pred Loop(This: List) {
    // Bug: should use This.header instead of header
    all n: Node | n in This.header.link.^(link)
    // Bug: should use This.header instead of header
    no This.header or #This.header = 1 //added "This."
}

// Overconstraint.  Should allow no n.link
pred Sorted(This: List) {
    // Fixed bug by adding "n.link & This" 
    all n: Node | n.link & This.elem <= n.elem
}

assert repair_assert_2 {
    all l: List | Loop[l] <=> {
    no l.header or one n: l.header.*link | n = n.link
}}

pred repair_epred_2 {
    all l: List | Loop[l] <=> {
    no l.header or one n: l.header.*link | n = n.link
}}

run repair_epred_2

pred RepOk(This: List) {
    Loop[This]
    Sorted[This]
}

// Underconstraint.  x.~elem may not be in This. Correct if all nodes in List.
pred Count(This: List, x: Int, result: Int) {
    RepOk[This]
    result = #(x.~(elem))
}

abstract sig Boolean {}
one sig True, False extends Boolean {}
// Underconstraint.  x.~elem may not be in This. Correct if all nodes in List.
pred Contains(This: List, x: Int, result: Boolean) {
    RepOk[This]
    some x.~(elem) => result = True else result = False
}

fact IGNORE {
  one List
  List.header.*link = Node
}