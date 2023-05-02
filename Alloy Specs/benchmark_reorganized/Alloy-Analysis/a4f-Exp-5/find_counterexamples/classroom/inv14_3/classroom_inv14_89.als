pred inv14_OK {
	all s : Student, c : Class | (some Teacher & Teaches.c) implies some s.(Teacher & Tutors.c.Groups) 
}
assert inv14_Repaired {
	inv14[] iff inv14_OK[]
}