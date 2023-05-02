pred weaklyConnectedOK {
	all x, y : Node | (x->y in adj) or (y->x in adj) 
}