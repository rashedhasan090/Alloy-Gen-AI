fixed code:

pred inv5_OK {
	all s:State, e:Event | lone e.(s.trans.State)
}

assert inv5_Repaired {
	inv5[] iff inv5_OK[]
}

check inv5_Repaired expect 0