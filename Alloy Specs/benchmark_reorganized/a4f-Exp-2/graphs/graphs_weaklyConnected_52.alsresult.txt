// Bug fixed in weaklyConnected predicate
pred weaklyConnected {
    all n: Node | n in n.(n->(n.*(adj+~adj)))
}