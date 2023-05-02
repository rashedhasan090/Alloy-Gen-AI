
pred weaklyConnectedOK {
	all n:Node | n in (n.^adj + n.^~adj)
}

Here, the node n is checked to be present in the set of all nodes that can be reached from n in both directions (adj and ~adj).