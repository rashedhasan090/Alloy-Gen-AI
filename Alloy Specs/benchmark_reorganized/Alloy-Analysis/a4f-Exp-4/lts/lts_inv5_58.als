
/*
All the states have the same events available.
*/
pred inv5 {
    all e:Event | some s:State | e.(s.trans) 
    all x, y : State | some x->Event implies some y->Event 
}