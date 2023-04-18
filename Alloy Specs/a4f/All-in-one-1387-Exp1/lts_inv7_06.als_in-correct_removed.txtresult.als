There is a commented out code block in inv7 that needs to be removed. The fixed code is:

/* The LTS is reversible, ie, from a reacheable state it is always possible 
to return to an initial state.*/
pred inv7 {
  let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
  all s : Init.^tr | some i : Init | i in s.^tr --correct
}