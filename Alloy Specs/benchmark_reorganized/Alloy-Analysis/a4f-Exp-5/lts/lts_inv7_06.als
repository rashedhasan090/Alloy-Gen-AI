pred inv7_OK {
    let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
    all s : Init.^tr | some i : Init | i in s.^tr 
    all s1,s2:State, e:Event  | s1->e->s2 in trans implies s2->e->s1 in trans 
}