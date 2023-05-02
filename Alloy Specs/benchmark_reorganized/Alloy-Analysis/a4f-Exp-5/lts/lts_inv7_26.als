pred inv7_OK {
    let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
    all s : Init.^tr |
        some i : Init |
            s in i.^tr 
}
pred inv7 {
    let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
    all x : State, y : Init, z : Event | x in y.^tr and z in x.trans and y in z.(x.trans) 
}
