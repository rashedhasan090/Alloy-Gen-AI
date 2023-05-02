
pred inv4 {
	all s:State | some i:Init | i->Event->s in trans
}

This ensures that every state has a reachable path from an initial state, which is what the comment describes.