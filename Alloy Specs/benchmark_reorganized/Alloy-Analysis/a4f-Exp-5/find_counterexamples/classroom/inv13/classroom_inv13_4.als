pred inv13_OK {
	all t:Teacher | t not in Person.^~Tutors //fixed
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}