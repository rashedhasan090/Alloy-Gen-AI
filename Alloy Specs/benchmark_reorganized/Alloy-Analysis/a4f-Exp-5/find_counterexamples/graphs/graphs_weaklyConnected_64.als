pred weaklyConnectedOK {
    all n:Node | n in n.*(adj+~adj)
}
assert weaklyConnectedRepaired {
    weaklyConnected[] iff weaklyConnectedOK[]
}
```