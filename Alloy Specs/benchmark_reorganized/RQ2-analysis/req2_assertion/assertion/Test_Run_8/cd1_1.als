sig Class {
  ext: lone Class
}

one sig Object extends Class {}

pred ObjectNoExt() {
  all c: Class | c != Object implies Object !in c.^ext
}

pred Acyclic() {
  all c: Class | c !in c.^ext
}

pred AllExtObject() {
  all c: Class - Object | c in Object.*ext
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
run repair_pred_1  // output: pred repair_pred_1 is consistent, as expected