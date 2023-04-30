pred inv13_OK {
	all t : Teacher, s : Student | t.Tutors.s 
}
assert inv13_Repaired {
	inv13[] iff inv13_OK[]
}