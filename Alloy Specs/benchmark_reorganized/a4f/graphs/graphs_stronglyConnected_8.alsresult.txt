There is a bug in the `stonglyConnected` predicate. The correct predicate is provided below:

```
pred stonglyConnected {
    all n:Node | Node in n.^adj + n.~adj 
}
```