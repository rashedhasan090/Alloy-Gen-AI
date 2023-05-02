pred weaklyConnectedOK {
	all n1,n2:Node | n2 in n1.*adj or n2 in n1.~adj
}
assert weaklyConnectedRepaired {
   weaklyConnected[]  iff weaklyConnectedOK[]
}