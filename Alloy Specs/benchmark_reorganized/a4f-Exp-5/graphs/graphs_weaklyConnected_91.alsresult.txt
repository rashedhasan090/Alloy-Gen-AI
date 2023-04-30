pred weaklyConnectedOK {
	all x : Node | Node in x.*(adj + ~adj)
}
assert weaklyConnectedRepaired {
   weaklyConnected[]  iff weaklyConnectedOK[]
}