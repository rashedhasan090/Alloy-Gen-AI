pred weaklyConnectedOK {
	all n:Node | Node in (n.*(adj+~adj)).adj // Fixed bug: added parentheses around (adj+~adj)
}
assert weaklyConnectedRepaired {
   weaklyConnected[]  iff weaklyConnectedOK[]
}
