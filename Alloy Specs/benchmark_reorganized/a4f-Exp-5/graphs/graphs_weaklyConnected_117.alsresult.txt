pred weaklyConnectedOK {
	all x, y: Node | ^adj.x in ^adj.y or ^adj.y in ^adj.x
}
assert weaklyConnectedRepaired {
    weaklyConnected[] iff weaklyConnectedOK[]
}