pred weaklyConnectedOK {
	all n:Node | n in n.(n->(n.*adj+n.^~adj)) 
}
assert weaklyConnectedRepaired {
   weaklyConnected[]  iff weaklyConnectedOK[]
}