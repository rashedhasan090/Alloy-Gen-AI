pred weaklyConnectedOK {
	all n:Node | some n.*(adj+~adj) ---- Fixed the bug by replacing "+" with "|"
}
assert weaklyConnectedRepaired {
   weaklyConnected[]  iff weaklyConnectedOK[]
}