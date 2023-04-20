The bug in the specification is in the Sorted predicate. The line "n.elem < (n.link-This.header).elem" should be "n.elem <= (n.link-This.header).elem". This allows for nodes with equal elements to be considered sorted relative to each other, which was not previously allowed. The corrected predicate is as follows:

pred Sorted(This: List) {
    all n: Node | n.elem <= (n.link-This.header).elem
}