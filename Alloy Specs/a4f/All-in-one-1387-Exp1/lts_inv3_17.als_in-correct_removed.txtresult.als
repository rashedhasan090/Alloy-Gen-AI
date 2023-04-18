The bug in the specification is in the predicate inv3, where the lone keyword is used instead of one. The correct predicate should be:

pred inv3 {
    all s : State, e : Event | one e.(s.trans)
}