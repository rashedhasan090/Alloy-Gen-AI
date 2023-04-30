pred weaklyConnectedOK {
	all n:Node | Node in (n+ n.*(adj+~adj) + *(adj+~adj).n).*(adj+~adj)
}
assert weaklyConnectedRepaired {
   weaklyConnected[]  iff weaklyConnectedOK[]
}