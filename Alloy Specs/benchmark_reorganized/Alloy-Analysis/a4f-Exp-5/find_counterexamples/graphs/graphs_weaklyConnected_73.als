pred weaklyConnectedOK {
	all n: Node | n in n.^adj + n.^~adj
}