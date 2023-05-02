sig Element {}
one sig Array {
  // Maps indexes to elements of Element.
  i2e: Int -> Element,
  // Represents the length of the array.
  length: Int
}
// Assume all elements are in the array.
fact Reachable {
  Element = Array.i2e[Int]
}

fact InBound {
  // All indexes should be greater than or equal to 0 and less than the array length.
  all i: Array.i2e.Element | i->Int in Array.i2e->Int and i->Int>=0 and i->Int<Array.length
  // Array length should be greater than or equal to 0.
  Array.length>=0
}

pred NoConflict() {
  // Each index maps to at most one element.
  all i, j: Int | i!=j => Array.i2e[i]!=Array.i2e[j]
}
run NoConflict

assert repair_assert_1{
  NoConflict()
  all i: Array.i2e.Element | i->Int in Array.i2e->Int and i->Int>=0 and i->Int<Array.length
}
check repair_assert_1

pred repair_pred_1{
  NoConflict()
  all i: Array.i2e.Element | i->Int in Array.i2e->Int and i->Int>=0 and i->Int<Array.length
}
run repair_pred_1