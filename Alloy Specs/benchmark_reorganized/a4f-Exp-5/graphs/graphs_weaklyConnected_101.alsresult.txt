pred weaklyConnectedOK {
	all x : Node | x in x.^adj + ^adj.x 
}
assert weaklyConnectedRepaired {
   weaklyConnected[]  iff weaklyConnectedOK[]
}