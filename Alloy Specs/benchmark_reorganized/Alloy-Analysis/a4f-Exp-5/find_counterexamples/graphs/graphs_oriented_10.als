/*
*/

pred oriented {
	all x, y : Node | (x->y in adj and y->x in adj) implies x != y 
}