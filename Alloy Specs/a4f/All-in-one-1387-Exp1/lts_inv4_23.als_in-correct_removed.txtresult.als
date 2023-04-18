The bug in the specification is in the predicate inv4. The correct code is:

/* All states are reachable from an initial state. */
pred inv4 {
  all s: State | some (Init.*trans).(s)
}