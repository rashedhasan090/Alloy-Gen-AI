pred noLoopsOK {
    no (iden & adj)
}
assert noLoopsRepaired {
    noLoops[] iff noLoopsOK[]
}
```