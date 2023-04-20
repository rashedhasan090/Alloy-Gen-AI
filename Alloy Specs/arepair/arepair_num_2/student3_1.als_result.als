The bug in the specification is in the Loop predicate. The correct version should be:

```
pred Loop(This: List) {
    no n: Node | n in This.header.*link && n = n.^link
    one n: Node | n.link = This.header
}
```

The bug in the Sorted predicate is that the expression `(n.link-This.header)` is not a set, so you cannot apply the `elem` operator to it. The correct version should be:

```
pred Sorted(This: List) {
    all n: Node | n.link.elem > n.elem iff n in This.header.*link
}
```

With these changes, the assertions should hold.