The bug in the specification is in the predicate AllExtObject(). The correct predicate is as follows:

pred AllExtObject() {
  // Each class other than Object is a sub-class of Object.
  all c: Class - Object | Object in c.*ext
}

The change is in the operator used in the expression "c.^ext". It should be "*ext" instead of "^ext". 

With this change, the specification should satisfy the assertions.