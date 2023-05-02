pred weaklyConnectedOK {
    //Fixed
    all a,b:Node | a in b.^adj or b in a.^adj
}
assert weaklyConnectedRepaired {
    weaklyConnected[]  iff weaklyConnectedOK[]
}