pred inv12_OK {
	all t : Teacher, c : Class | c -> t -> one (t.Teaches).Groups
}
assert inv12_Repaired {
    inv12[] iff inv12_OK[]
}