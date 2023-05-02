
pred inv4 {
    all s: State | some Init.(^trans).s 
}

Here, we use transitive closure `^trans` to get all the states that can be reached from an initial state, and then check if all states are reachable from at least one initial state.