There is a bug in the `stonglyConnected` predicate. The correct version of the predicate should be:

```
pred stonglyConnected {
 	all n:Node | Node in n.*(adj+~adj)
}
```
The error in the original predicate is that it only checks for one direction of the edges, but not the other. The fixed predicate uses the reflexive and transitive closure (`.*`) to check both directions of the edges.