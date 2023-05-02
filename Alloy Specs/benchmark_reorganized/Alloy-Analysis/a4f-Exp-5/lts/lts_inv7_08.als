pred inv7_OK {
	all s1,s2:State, e1,e2:Event  | s1->e1->s2 in trans implies s2->e2->s1 in trans  
    let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
    all s : Init.^tr | some i : Init | i in s.^tr 
}
assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}