sig Class {
  ext: lone Class
}

one sig Object extends Class {}

pred ObjectNoExt() {
  // Object does not extend any class.
  // Fixed:
  no Object.ext
}

pred Acyclic() {
  // No class is a sub--class of itself (transitively).
  all c: Class | c !in c.^ext
}

pred AllExtObject() {
  // Each class other than Object is a sub--class of Object.
  // Fixed:
  all c: Class | c = Object or c in c.*ext
}

pred ClassHierarchy() {
  ObjectNoExt
  Acyclic
  AllExtObject
}

run ClassHierarchy for 3

assert repair_assert_1{
	ObjectNoExt <=>  no Object.ext
}
check repair_assert_1

pred repair_pred_1 {
	ObjectNoExt <=>
		no Object.ext
}
run repair_pred_1