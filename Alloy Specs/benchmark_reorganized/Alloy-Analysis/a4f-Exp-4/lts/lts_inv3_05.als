There is a bug in `inv3`, the correct version is:

pred inv3_OK {
    all s : State | all e, e' : Event | (s.trans[e] != s.trans[e']) or (e = e')
}

Which can also be written as:

pred inv3_OK {
    all s : State | #(s.trans) = #(Event)
}

Here, `inv3` ensures that each state has at most one transition for each event. The original version used `lone`, which allows for a state to have no transitions for an event. This contradicts with `inv1`, which states that every state must have at least one transition.