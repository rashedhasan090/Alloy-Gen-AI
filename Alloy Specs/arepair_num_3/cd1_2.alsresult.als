The bug is in the predicate AllExtObject. The body of the formula is wrong.
The corrected predicate is:

pred AllExtObject() {
  // Each class other than Object is a sub-class of Object.
  all c: Class - Object | Object in c.^ext
}

The corrected formula checks that all classes other than Object are sub-classes of Object. The updated assert and pred should look like this:

assert repair_assert_2{
 AllExtObject <=>  all c: Class - Object | c in Object.^~ext
}

pred repair_pred_2{
 AllExtObject <=>  all c: Class - Object | c in Object.^~ext
}