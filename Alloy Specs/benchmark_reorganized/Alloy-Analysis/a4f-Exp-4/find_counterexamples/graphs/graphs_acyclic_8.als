
```
pred complete {
    all n1, n2: Node | n1 != n2 implies n2 in n1.*(adj+~adj)
}
```