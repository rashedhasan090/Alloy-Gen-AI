pred weaklyConnectedOK {
	all n:Node | n in n.*(adj+~adj) //fixed: changed Node to n
}

assert weaklyConnectedRepaired {
   weaklyConnected[]  iff weaklyConnectedOK[]
}