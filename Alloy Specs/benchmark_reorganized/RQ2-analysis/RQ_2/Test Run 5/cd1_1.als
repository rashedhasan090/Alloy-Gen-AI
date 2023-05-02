sig Class {
  ext: lone Class
}

one sig Object extends Class {}

pred ObjectNoExt() {
  all c: Class | c != Object => Object !in c.^ext //fixed bug
}

pred Acyclic() {
  all c: Class | c !in c.^ext
}

pred AllExtObject() {
  all c: Class -- Object | c in Object.*ext //fixed formula
}

pred ClassHierarchy() {
  ObjectNoExt
  Acyclic
  AllExtObject
}

run ClassHierarchy for 3