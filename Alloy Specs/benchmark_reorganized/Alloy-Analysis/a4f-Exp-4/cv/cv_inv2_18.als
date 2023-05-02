
```
pred inv2 {
    all u : User | u.profile & source = u.source -> u.visible in u.profile
}
```