The bug is in the predicates `ContainsR` and `Contains` where they are not properly defined. Here are the corrected predicates:

```
pred ContainsR (This: List, x: Int, result: Boolean) {
    RepOk[This]
    (result = False) && (x !in This.header.*link.elem)
}

pred Contains (This: List, x: Int, result: Boolean) {
    RepOk[This]
    ((x !in This.header.*link.elem) => (result = False)) && ((x in This.header.*link.elem) => (result = True))
}
```