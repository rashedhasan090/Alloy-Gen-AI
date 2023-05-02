
```
pred weaklyConnectedOK {
    all x, y : Node | Node in x.^adj + y.^~adj 
}
```

This predicate checks if it is possible to reach every node from every other node in both directions ignoring the edge direction.