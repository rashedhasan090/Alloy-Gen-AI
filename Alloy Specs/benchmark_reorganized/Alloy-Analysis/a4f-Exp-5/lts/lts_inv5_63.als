/* Fixed code */
pred inv5_OK {
	all e: Event | all x, y: State | e in x.trans implies e in y.trans
}
assert inv5_Repaired {
	inv5[] iff inv5_OK[]
}