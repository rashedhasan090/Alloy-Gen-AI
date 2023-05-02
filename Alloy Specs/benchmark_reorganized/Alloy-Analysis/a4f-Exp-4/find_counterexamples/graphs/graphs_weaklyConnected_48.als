
```
pred weaklyConnectedOK {
  all n: Node |
    all m: Node |
      some path: n.*(adj & ~adj) |
        m in path
}
```