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
  all c: Class - Object | c in Object.^ext
}

pred ClassHierarchy() {
  ObjectNoExt
  Acyclic
  AllExtObject
}

assert repair_assert_1{
	ObjectNoExt <=>  all c: Class | Object !in c.~^ext
}
check repair_assert_1

pred repair_pred_1 {
		ObjectNoExt <=>
  all c: Class | Object !in c.~^ext
}
run repair_pred_1