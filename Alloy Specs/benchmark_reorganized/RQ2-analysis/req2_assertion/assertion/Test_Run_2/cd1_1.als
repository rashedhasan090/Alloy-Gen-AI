sig Class {
  ext: lone Class
}

one sig Object extends Class {}

pred ObjectNoExt() {
  all c: Class | Object !in c.^ext
  // Updated: added "and" to combine two assertions
  and no c: Class | c.ext = Object
}

pred Acyclic() {
  all c: Class | c !in c.^ext
}

pred AllExtObject() {
  // Updated: added "Object." to only consider sub-classes of Object
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