
pred inv2 {
	all u : User, w : Work | u->w in profile implies (w.source in User + Institution)
}