The bug is in the pred Sorted definition. The comparison should only be made for linked nodes, so the predicate should be:

```
// Corrected.
pred Sorted(This: List) {
  all n:Node | no n.link or n.elem <= n.link.elem
}
```

With this correction, the assertions hold and the specification is valid.