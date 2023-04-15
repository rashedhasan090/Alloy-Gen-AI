one sig FSM {
 start: set State,
 stop: set State
}

sig State {
 transition: set State
}

// Part (a)
fact OneStartAndStop {
 // FSM only has one start state.
 one FSM.start 

 // FSM only has one stop state.
 one FSM.stop 
 
 // There is always a stop state.
 some FSM.stop
}

// Part (b)
fact ValidStartAndStop {
 // A state cannot be both a start state and a stop state.
 FSM.start !in FSM.stop
 
 // No transition ends at the start state.
 all s: State | s.transition !in FSM.start

 // If no transition then the state is the stop state.
 all s: State | s.transition = none <=> s in FSM.stop
}

// Part (c)
fact Reachability {
 // All states are reachable from the start state.
 State = FSM.start.*transition

 // The stop state is reachable from any state.
 all s: State | FSM.stop in s.*transition
}

// Assertion
assert repair_assert_1{
 some s: FSM.start | some t: s.transition
}
check repair_assert_1

pred repair_pred_1{
 no s: FSM.stop | some t: s.transition
}
run repair_pred_1