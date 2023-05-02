
```
pred stonglyConnectedOK {
	all n:Node | Node in n.^adj+n.^~adj
}
```

The `^~adj` operator is added to ensure that it is possible to reach every node from every node considering edge direction.