The bug was in the inv4 predicate, where instead of checking if all states are reachable from an initial state, it checked if the State signature itself was a reachable state. The fixed predicate is below:

/*
All states are reachable from an initial state.
*/
pred inv4 {
    all s:State | some i:Init | i in s.*(trans.event)
} 

After this fix, all the assertions pass without any errors.