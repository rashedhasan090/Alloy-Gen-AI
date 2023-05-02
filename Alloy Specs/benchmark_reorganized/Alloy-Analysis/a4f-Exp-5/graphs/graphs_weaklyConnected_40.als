pred weaklyConnectedOK {
    all n:Node | n in (n+(n.adj) + (adj.(n.adj))).*(adj + ~adj)
}

assert weaklyConnectedRepaired {
    weaklyConnected[] iff weaklyConnectedOK[]
}