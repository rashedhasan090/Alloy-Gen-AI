pred weaklyConnectedOK {
	all x : Node | Node in x.^adj + x.^~adj
}