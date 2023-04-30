pred weaklyConnectedOK {
    all x, y : Node | x->y in adj iff y->x in adj or x = y or y in x.*(adj+~adj)*x
}
assert weaklyConnectedRepaired {
    weaklyConnected[]  iff weaklyConnectedOK[]
}
check weaklyConnectedRepaired expect 0