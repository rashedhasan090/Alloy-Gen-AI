pred weaklyConnectedOK {
	all x : Node | x in x.*adj + x.~adj 
}
assert weaklyConnectedRepaired {
   weaklyConnected[]  iff weaklyConnectedOK[]
}