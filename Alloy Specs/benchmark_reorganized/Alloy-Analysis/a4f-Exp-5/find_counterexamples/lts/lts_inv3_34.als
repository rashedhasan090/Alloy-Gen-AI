The fixed code for inv3 is:

pred inv3 {
  all s: State, e: Event | lone e.(s.trans)
}

There should be a dot between e and (s.trans) to indicate that the lone operator is referring to the function that maps an event to a state, instead of the set of events.