
```
pred inv5 {
    all s, s': State | lone e: Event | s.trans[e] = s'.trans[e]
}
```

This ensures that all states have the same events available.