Fixed code:

pred inv5_OK {
	all s:State, e:Event | some s':State | s'.trans = s.trans.e
}
assert inv5_Repaired {
	inv5[] iff inv5_OK[]
}