
pred weaklyConnectedOK {
    all n:Node | Node in n.^adj + n.^~adj + n
}
assert weaklyConnectedRepaired {
    weaklyConnected[]  iff weaklyConnectedOK[]
}