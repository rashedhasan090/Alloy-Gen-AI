The bug in the specification is in the Loop predicate. The line "#header > 0" should be changed to "some header". This fixes the overconstraint issue with the predicate.

Fixed Loop predicate:

// Overconstraint. Should allow no l.header
// Underconstraint.  Should not allow link = n1 -> n2 + n2 -> n3 + n3 -> n1
// Overconstraint. Should allow link = n1 -> n2 + n2 -> n3 + n3 -> n3
pred Loop(This: List) {
    all n: Node| n in This.header.link.^(link)
    some header
}

With this fix, the specification should be correct.