pred weaklyConnectedOK {
	all a,b:Node | a->b in (adj+~adj)
}