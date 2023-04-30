pred weaklyConnectedOK {
	all a,b:Node | b in a.*adj + a.^adj + a lone (a -> a)
}
assert weaklyConnectedRepaired {
   weaklyConnected[]  iff weaklyConnectedOK[]
}