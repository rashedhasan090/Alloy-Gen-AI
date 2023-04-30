pred weaklyConnectedOK {
	all x, y : Node | y in x.^adj or x in y.^adj
}
assert weaklyConnectedRepaired {
   weaklyConnected[]  iff weaklyConnectedOK[]
}