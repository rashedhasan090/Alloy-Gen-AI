
pred inv1 {
    all s1, s2:State | s1 != s2 => some e:Event | s1->e->s2 in trans
}

This fixes the issue with the original predicate where it is possible for a state to not have any transitions. Other than this, the code seems to be correct.