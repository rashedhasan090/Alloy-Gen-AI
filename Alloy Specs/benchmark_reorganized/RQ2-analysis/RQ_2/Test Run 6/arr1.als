sig Element {}
one sig Array {
  i2e: Int -> Element,
  length: Int
}
fact Reachable {
  Element = Array.i2e[Int]
}
fact InBound {
  all i: Array.i2e.Element | i >= 0 and i < Array.length
  Array.length >= 0
}
pred NoConflict() {
  all i, j: Int | i != j => Array.i2e[i] != Array.i2e[j]
}
run NoConflict

assert repair_assert_1{
  NoConflict
  all i: Int | i >= 0 and i < Array.length
}
check repair_assert_1

pred repair_pred_1{
  NoConflict
  all i: Int | i >= 0 and i < Array.length
}
run repair_pred_1