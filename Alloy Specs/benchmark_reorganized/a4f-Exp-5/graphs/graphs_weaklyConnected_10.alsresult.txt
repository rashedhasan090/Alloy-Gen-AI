pred weaklyConnectedOK {
	all a,b:Node | b in a.*(adj+~adj) and a in b.*(adj+~adj)
}
assert weaklyConnectedRepaired {
   weaklyConnected[]  iff weaklyConnectedOK[]
}