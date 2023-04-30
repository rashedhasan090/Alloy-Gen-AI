The fixed code for inv5 is:

/*
All the states have the same events available.
*/
pred inv5 {
  all s1,s2:State | (s1.trans).Event = (s2.trans).Event
}