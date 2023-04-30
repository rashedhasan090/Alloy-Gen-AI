Fixed code:

pred inv5_OK {
	all s:State, s1:State, e:Event | s.trans[e] = s1.trans[e]
}

assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}