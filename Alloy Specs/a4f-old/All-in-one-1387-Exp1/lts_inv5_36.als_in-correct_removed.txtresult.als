The bug in the specification is in inv5. The correct code for inv5 is as follows:

pred inv5 {
    all s: State, e: Event | lone e.(s.trans.State) --fixed
}