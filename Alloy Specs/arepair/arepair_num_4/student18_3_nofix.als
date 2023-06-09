sig List {
    header : set Node
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

// Underconstraint.  Should disallow header = l1 -> n1, no link
pred Loop(This: List) {
    no This.header.link || one n: This.header.*link | n.link = n
}

// Overconstraint.  Should allow no n.link
pred Sorted(This: List) {
    all n: This.header.*link | one n.link && n.elem <= n.link.elem
}

pred RepOk(This: List) {
    Loop[This]
    Sorted[This]
}

// Underconstraint.  Should be && instead of ||
pred Count(This: List, x: Int, result: Int) {
    RepOk[This]
    result = #{n: Node | n in This.header.*link || n.elem = x}
}

assert repair_assert_3{
	all l:List | all x:Int | all result: Int |
	Count[l, x, result] <=> {
     RepOk[l]
	 result = #{n: Node | n in l.header.*link && n.elem = x}
}
}
check repair_assert_3

pred repair_pred_3{
all l:List | all x:Int | all result: Int |
	Count[l, x, result] <=> {
     RepOk[l]
	 result = #{n: Node | n in l.header.*link && n.elem = x}
}
}
run repair_pred_3

abstract sig Boolean {}
one sig True, False extends Boolean {}

// Correct
pred Contains(This: List, x: Int, result: Boolean) {
    RepOk[This]
    {some n: This.header.*link | n.elem = x} => result = True else result = False
}

fact IGNORE {
  one List
  List.header.*link = Node
}
