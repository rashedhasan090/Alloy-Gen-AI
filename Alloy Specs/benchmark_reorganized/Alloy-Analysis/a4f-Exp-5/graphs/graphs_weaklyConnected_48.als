pred weaklyConnectedOK {
	all n:Node | Node in (n.*(adj+~adj)).^(adj+~adj)
}
assert weaklyConnectedRepaired {
   weaklyConnected[]  iff weaklyConnectedOK[]
}