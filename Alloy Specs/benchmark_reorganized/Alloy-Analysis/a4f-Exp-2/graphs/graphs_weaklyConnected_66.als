There are two bugs in the weaklyConnected predicate. The correct code is:

pred weaklyConnected {
	all n: Node | n in n.*(adj + ~adj)
}