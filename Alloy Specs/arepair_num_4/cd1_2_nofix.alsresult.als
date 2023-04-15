The bug in this specification is in the predicate AllExtObject. 

The correct version of the predicate should be:

```
pred AllExtObject() {
  // Each class other than Object is a sub-class of Object.
  all c: Class - Object | Object in c.^ext
}
```

The fix is to reverse the direction of the relation in the formula, so that we check whether Object is in the transitive closure of the extension relation starting from each class other than Object.