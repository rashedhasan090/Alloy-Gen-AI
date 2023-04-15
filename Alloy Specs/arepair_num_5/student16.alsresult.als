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

// Fixed bug: added transitive closure operator to find the loop
pred Loop(This: List) {
    some n: Node | n in This.header.*link and n = n.*(This.header.*link)
}

assert repair_assert_1{
    all l : List | Loop[l] <=> {no l.header or one n: l.header.*link | n = n.link}
}
check repair_assert_1

pred repair_pred_1{
    all l : List | Loop[l] <=> {no l.header or one n: l.header.*link | n = n.link}
}
run repair_pred_1

// Fixed bug: added ordering constraint between elements in the list
pred Sorted(This: List) {
    all n: Node, m: Node | n.link = m => n.elem < m.elem
}

pred RepOk(This: List) {
     Loop[This]
     Sorted[This]
}

// Fixed bug: added counting logic
pred Count(This: List, x: Int, result: Int) {
     RepOk[This]
     result = #(n: Node | n in This.header.*link and x in n.elem)
}

abstract sig Boolean {}
one sig True, False extends Boolean {}

// Fixed bug: added checking if element exists
pred Contains(This: List, x: Int, result: Boolean) {
     RepOk[This]
     result = (some n: Node | n in This.header.*link and x in n.elem)
}

fact IGNORE {
  one List
  List.header.*link = Node
}