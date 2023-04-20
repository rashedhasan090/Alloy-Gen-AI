The bug in this specification is in the InBound fact. The line "all i:Int |i>=0 and i<Array.length" should be "all i: Array.i2e.Element | i>=0 and i<Array.length". The corrected fact is:

fact InBound {
  // All indexes should be greater than or equal to 0 and less than the array length.
  all i: Array.i2e.Element | i>=0 and i<Array.length
  // Array length should be greater than or equal to 0.
  Array.length>=0
}