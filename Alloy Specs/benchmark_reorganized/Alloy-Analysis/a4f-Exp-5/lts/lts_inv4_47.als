The fixed code for the bug in inv4 is:

pred inv4 {
    all x : Init, y : Event | y in (x.trans).*State 
}

This will ensure that all states are reachable from an initial state via some transition.