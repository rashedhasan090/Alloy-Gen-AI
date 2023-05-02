pred weaklyConnectedOK {
	all a,b:Node | a->b in adj or b->a in adj 
}
assert weaklyConnectedRepaired {
   weaklyConnected[]  iff weaklyConnectedOK[]
}