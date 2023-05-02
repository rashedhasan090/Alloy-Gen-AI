sig Class {
  ext: lone Class
}

one sig Object extends Class {}

pred ObjectNoExt() {
  all c: Class | c != Object implies Object !in c.^ext // bugfix: exclude Object from the quantification and add a condition
}

pred Acyclic() {
  all c: Class | c !in c.^ext
}

pred AllExtObject() {
  all c: Class -- Object | c in Object.*ext // bugfix: replace c.*ext with Object.*ext
}

pred ClassHierarchy() {
  ObjectNoExt
  Acyclic
  AllExtObject
}

run ClassHierarchy for 3