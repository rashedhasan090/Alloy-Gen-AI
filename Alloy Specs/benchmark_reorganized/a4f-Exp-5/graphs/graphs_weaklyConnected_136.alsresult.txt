//Fixed code:

pred weaklyConnected {
	all x, y : Node | (x->y in adj or y->x in adj) or (
    some z : Node | x->z in adj and z->y in adj
	)
}