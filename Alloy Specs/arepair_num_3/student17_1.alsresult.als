The bug in this specification is in the pred Sorted. The comparison between n.elem and n.link.elem should be a strict inequality, i.e., n.elem < n.link.elem. Change it to:

```
pred Sorted(This: List) {
   all n: This.header.*link | n.link = none or n.elem < n.link.elem
}
```

This will allow for nodes with no link, i.e., last nodes, in the list.