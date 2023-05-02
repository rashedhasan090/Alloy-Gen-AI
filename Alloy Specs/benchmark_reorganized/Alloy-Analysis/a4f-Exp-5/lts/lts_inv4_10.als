The fixed code for the inv4 predicate is:

pred inv4_OK {
  let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
  all s : State | some (Init <: tr).*s
}

Note the use of the transitive closure operator "*". This fixed predicate says that for all states s, there exists a path initiated from some initial state in which s is a part of.