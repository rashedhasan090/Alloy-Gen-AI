// Fixed code for inv4
pred inv4_OK {
 let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
  Init in Event.*[tr].State 
}