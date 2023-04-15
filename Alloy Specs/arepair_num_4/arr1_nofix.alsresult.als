The bug is in the "fact InBound" constraint. Instead of using "Array.i2e" in the quantifier, it should use "Element". The corrected constraint is:

fact InBound {
  // All indexes should be greater than or equal to 0 and less than the array length.
  all i: Element | i in Array.i2e[Int] and i>=0 and i<Array.length
  // Array length should be greater than or equal to 0.
  Array.length>=0
}