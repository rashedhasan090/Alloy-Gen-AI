sig Class {
  ext: lone Class
}

one sig Object extends Class {}

pred ObjectNoExt() {
  all c: Class | Object !in c.^ext
}

pred Acyclic() {
  all c: Class | c !in c.^ext
}

pred AllExtObject() {
  all c: Class | c in Object.*ext
}

pred ClassHierarchy() {
  ObjectNoExt
  Acyclic
  AllExtObject
}

assert repair_assert_1{
	ObjectNoExt <=>  all c: Class | Object !in c.~^ext
}

pred repair_pred_1 {
	ObjectNoExt <=> all c: Class | Object !in c.~^ext
}

check ClassHierarchy for 3
check repair_assert_1
run repair_pred_1 for 3