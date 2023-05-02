
pred inv5_OK {
    all s:State, e:Event | e in s.trans.Event
}

The corrected predicate checks that every event is in the set of events available in each state.