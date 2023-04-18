There is a commented out line in the inv5 predicate that needs to be removed. The correction is as follows:

/* 
All the states have the same events available.
*/
pred inv5 {
    all s, s1 : State | s.trans.Event = s1.trans.Event --fixed
}