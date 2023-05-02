
```
pred weaklyConnected {
   all x, y : Node | x in ^*(adj+~adj) and y in ^*(adj+~adj) implies x in ^adj.y and y in ^adj.x
}
```