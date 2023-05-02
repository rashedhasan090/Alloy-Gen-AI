pred weaklyConnectedOK {
    all x : Node | x in x.*(adj + ~adj)
}
assert weaklyConnectedRepaired {
    weaklyConnected[]  iff weaklyConnectedOK[]
}