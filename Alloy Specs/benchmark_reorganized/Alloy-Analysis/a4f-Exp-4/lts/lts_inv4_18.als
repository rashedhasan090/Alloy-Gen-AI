
pred inv4 {
  all s: State | some Init.(Init -> s in trans)
}