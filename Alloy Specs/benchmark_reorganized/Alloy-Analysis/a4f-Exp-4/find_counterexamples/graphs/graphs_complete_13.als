```
pred complete {
  all n:Node | n.adj = Node -- n
}
```
This predicate ensures that every node is connected to every other node in the graph.