There are two bugs in the `weaklyConnected` predicate. The fixed code is:

```
pred weaklyConnected {
	all n:Node | n in n.(~adj + adj)
}
```