The bug in the specification is in part (c) of the specification. The fact Reachability needs to be modified to ensure that there are no unreachable states. This can be done by adding the following expression:

// No state is unreachable.
no s: State | no s.*transition & (State - s)

This expression checks that for all states s, there is no state that cannot be reached from s. The updated Reachability fact looks as follows:

fact Reachability {
  // All states are reachable from the start state.
  State = FSM.start.*transition

  // The stop state is reachable from any state.
  all s: State | FSM.stop in s.*transition

  // No state is unreachable.
  no s: State | no s.*transition & (State - s)
}

With this modification, the assertions are satisfied.