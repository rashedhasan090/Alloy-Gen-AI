The bug in the specification is in the AllExtObject predicate. The correct formula should be:

all c: Class - Object | Object in c.*ext

This checks that each class other than Object is reachable from Object through ext. 

Here is the corrected specification:

sig Class {
  ext: lone Class
}

one sig Object extends Class {}

pred ObjectNoExt() {
  // Object does not extend any class.
  all c: Class | Object !in c.^ext
}

pred Acyclic() {
  // No class is a sub-class of itself (transitively).
  all c: Class | c !in c.^ext
}

pred AllExtObject() {
  // Each class other than Object is a sub-class of Object.
  all c: Class - Object | Object in c.*ext
}

pred ClassHierarchy() {
  ObjectNoExt
  Acyclic
  AllExtObject
}

//run ClassHierarchy for 3



assert repair_assert_2{
 AllExtObject <=>  all c: Class - Object | c in Object.^~ext
}
check repair_assert_2

pred repair_pred_2{
 AllExtObject <=>  all c: Class - Object | c in Object.^~ext
}
run repair_pred_2