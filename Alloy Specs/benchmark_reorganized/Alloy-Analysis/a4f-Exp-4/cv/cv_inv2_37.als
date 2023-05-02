
```
pred inv2 {
	all u:User, w:Work | w in u.profile implies (u in w.source or some i:Institution | i = w.source) 
}
``` 

Note that in the original `inv2`, the `i in w.source` is incorrect, it should be `i = w.source`.