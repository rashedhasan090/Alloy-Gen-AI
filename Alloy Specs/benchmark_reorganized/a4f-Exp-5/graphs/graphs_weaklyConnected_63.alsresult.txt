pred weaklyConnectedOK {
	all n:Node | Node in n.*(adj+^~adj)
}