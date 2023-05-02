
/*
All states have the same events available.
*/
pred inv5 {
    all e: Event | some s: State | e in s.trans
}