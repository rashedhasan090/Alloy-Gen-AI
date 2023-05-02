There is a missing negation operator in the `undirected` predicate. The corrected predicate should be:

```
pred undirected {
    Node.adj = ~Node.adj
}
```