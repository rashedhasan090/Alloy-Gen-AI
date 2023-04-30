sig List {
    header: set Node
}

sig Node {
    link: set Node,
    elem: set Int
}

fact CardinalityConstraints {
    all l: List | lone l.header
    all n: Node | lone n.link && one n.elem
}

pred Loop(This: List) {
    This.header.*link = Node
    no This.header || one n: This.header.*link | n in n.link
}

pred Sorted(This: List) {
     all n: This.header.*link | some m: n.link | n.elem <= m.elem
}

pred RepOk(This: List) {
    Loop[This]
    Sorted[This]
}

pred Count(This: List, x: Int, result: Int) {
    RepOk[This]
    result = #{ n: This.header.*link | n.elem = x }
}

abstract sig Boolean {}
one sig True, False extends Boolean {}

pred Contains(This: List, x: Int, result: Boolean) {
    all n: This.header.*link | n.elem = x implies result = True else result = False
}

fact {all l : List | RepOk[l]}

assert repair_assert_2{
    all l:List | all x:Int |
        Contains[l, x, True] <=> 
        {
        some n: l.header.*link | n.elem = x 
    }
}

check repair_assert_2

pred repair_pred_2{
    all l:List | all x:Int |
            Contains[l, x, True] <=> 
        {
        some n: l.header.*link | n.elem = x 
    }
}

run repair_pred_2

fact IGNORE {
  one List
  List.header.*link = Node
}