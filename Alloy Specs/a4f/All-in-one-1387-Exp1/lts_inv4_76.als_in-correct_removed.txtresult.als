The bug in the specification is in predicate inv4. The correct code is:

pred inv4 {
  let tr = { s1, s2 : State, e : Event | s1->e->s2 } |
  State in Init.^tr
}