
/*
All states are reachable from an initial state.
*/
pred inv4 {
 all s : State | some x : Init | s in x.^trans
}