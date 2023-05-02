
pred weaklyConnectedOK {
	all n:Node | Node in n.*(n.^adj + ~n.^adj)
}