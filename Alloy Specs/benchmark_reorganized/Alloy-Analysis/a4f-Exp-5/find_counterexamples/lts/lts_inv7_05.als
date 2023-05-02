pred inv7_OK_fixed {
 all s1,s2:State | some e1:Event  | s1->e1->s2 in trans implies some e2:Event | s2->e2->s1 in trans 
}

assert inv7_Repaired_fixed {
    inv7[] iff inv7_OK_fixed[]
}

check inv7_Repaired_fixed expect 0