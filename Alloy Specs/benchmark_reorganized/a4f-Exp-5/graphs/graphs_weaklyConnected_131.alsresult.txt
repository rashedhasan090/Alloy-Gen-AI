pred weaklyConnectedOK {
	all x, y : Node | x in ^adj.y & y in ^adj.x
}
assert weaklyConnectedRepaired {
   weaklyConnected[]  iff weaklyConnectedOK[]
}