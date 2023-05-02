
/*
All states have the same events available.
*/
pred inv5 {
  all s1: State, s2: State | s1.trans.Event = s2.trans.Event 
}