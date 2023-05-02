pred weaklyConnectedOK {
	//Fixed: changed + to * in the expression
	all x : Node | Node in x.*(adj + ~adj)  
}
assert weaklyConnectedRepaired {
   weaklyConnected[] iff weaklyConnectedOK[]
}