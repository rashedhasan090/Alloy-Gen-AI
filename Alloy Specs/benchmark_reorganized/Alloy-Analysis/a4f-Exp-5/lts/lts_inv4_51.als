pred inv4_OK {
    let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
    all x : Init, y : Event | y in tr.^x.trans and State in y.*(x.trans) + x 
}