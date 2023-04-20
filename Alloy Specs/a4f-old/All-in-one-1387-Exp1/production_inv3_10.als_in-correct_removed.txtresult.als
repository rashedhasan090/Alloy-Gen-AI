There is a bug in the inv3 predicate. The correct code for inv3 predicate is:

pred inv3 {
    all c:Component | some r:Robot | r.rposition = c.cposition
}