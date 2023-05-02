
pred inv7 {
  let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
  all s : Init.^tr | some i : Init | i in s.^tr
}

The fixed code uses the trans relation to define a set of transitions tr, and then checks that all reachable states from an initial state have a path back to an initial state.