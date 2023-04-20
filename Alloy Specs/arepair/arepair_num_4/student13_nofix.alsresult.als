The bug in this specification is in the predicate Loop. The expression "n.link in n" should be "This in n.link". The correct predicate should be:

pred Loop (This : List){
    no This.header || one n:This.header.*link | This in n.link
}