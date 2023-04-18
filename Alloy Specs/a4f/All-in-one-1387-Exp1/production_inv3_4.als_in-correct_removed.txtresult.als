The bug in the specification is in inv3, where the comment shows that it is trying to check if Component's cposition is in Robot's rposition. The correct code is:

pred inv3 {
  all c:Component | some r:Robot | r.rposition = c.cposition
}