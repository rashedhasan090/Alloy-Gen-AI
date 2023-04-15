The bug is in the fact NoConflict. The quantifier should be for all indices in the array, not all elements in the array. 

The fixed fact NoConflict should be:

fact NoConflict {
  // Each index maps to at most one element
  all i:Array.i2e | #i = 0 or #i = 1
}