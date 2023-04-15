one sig FSM {
  start: set State,
  stop: set State
}

sig State {
  transition: set State
}

fact OneStartAndStop {
  #FSM.start = 1
  #FSM.stop = 1
}

fact ValidStartAndStop {
  FSM.start != FSM.stop
  all s:State | s !in FSM.start.transition // Fix: s !in FSM.start.transition
  no FSM.stop.transition
}

fact Reachability {
  State = FSM.start.*transition
  all s:(State - FSM.stop) | FSM.stop in s.*transition
}

//run {} for 5
assert repair_assert_1{
    all s: State | FSM.start !in s.transition
}
check repair_assert_1

pred repair_pred_1{
    all s: State | FSM.start !in s.transition
}
run repair_pred_1