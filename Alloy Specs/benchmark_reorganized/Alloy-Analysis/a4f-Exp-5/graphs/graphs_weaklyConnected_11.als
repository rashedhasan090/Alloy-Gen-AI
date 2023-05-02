pred weaklyConnectedOK {
	all a,b:Node | b in a.^adj or b in a.^~adj //fixed
}
assert weaklyConnectedRepaired {
   weaklyConnected[]  iff weaklyConnectedOK[]
}