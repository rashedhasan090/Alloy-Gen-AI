sig List {
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
    no This.header || one n: This.header.*link | n in n.^link
}

pred Sorted(This: List) {
    // Fix: Only require the link if there is more than one element in the list
    all n:This.header.*(link & elem.(This.*link)) | n.elem <= n.link.elem
}

pred RepOk(This: List) {
     Loop[This]
     Sorted[This]
}

pred Count(This: List, x: Int, result: Int) {
    RepOk[This]
    // Fix: Only consider nodes that contain x
    all n: This.header.*link | (x in n.elem <=> result = #n.elem)
}

abstract sig Boolean {}
one sig True, False extends Boolean {}

pred Contains(This: List, x: Int, result: Boolean) {
    RepOk[This]
    (some n: This.header.*link | x in n.elem && result = True) || (all n: This.header.*link | x !in n.elem && result = False)
}

fact IGNORE {
  one List
  List.header.*link = Node
}

assert repair_assert_2{
    all l:List | all x:Int | all result: Int |
    Count[l, x, result] <=> {
     RepOk[l]
     result = #{n: Node | n in l.header.*link && n.elem = x}
    }
}
check repair_assert_2

pred  repair_pred_2 {
        all l:List | all x:Int | all result: Int |
    Count[l, x, result] <=> {
     RepOk[l]
     result = #{n: Node | n in l.header.*link && n.elem = x}
    }
}
run  repair_pred_2