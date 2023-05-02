
/*
All states have the same events available.
*/
pred inv5 {
  all e : Event | all s1, s2 : State | e in s1.trans.State iff e in s2.trans.State
}