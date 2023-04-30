pred weaklyConnectedOK {
	all x, y : Node | some x.*adj + y.*adj
}

assert weaklyConnectedRepaired {
	weaklyConnected[] iff weaklyConnectedOK[]
}