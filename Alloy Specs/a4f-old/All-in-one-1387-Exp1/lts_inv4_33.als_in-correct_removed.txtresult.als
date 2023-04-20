The bug is in inv6 predicate, which is missing the 'in' keyword in the quantifier. The fixed code is:

/* Each event is available in at least a state. */
pred inv6 {
    all e:Event | some s1,s2:State | s1->e->s2 in trans --fixed
}