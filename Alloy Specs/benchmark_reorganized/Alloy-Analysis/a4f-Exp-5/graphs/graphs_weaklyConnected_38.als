pred weaklyConnectedOK {
	all n:Node | (Node -- n) in n.*(adj + ~adj)
}
assert weaklyConnectedRepaired {
   weaklyConnected[]  iff weaklyConnectedOK[]
}