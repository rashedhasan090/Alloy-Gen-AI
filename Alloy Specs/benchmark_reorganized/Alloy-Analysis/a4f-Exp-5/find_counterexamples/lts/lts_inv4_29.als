/* Fixed code */
pred inv4_OK {
 let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
  Init in Init.^tr 
}
assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}