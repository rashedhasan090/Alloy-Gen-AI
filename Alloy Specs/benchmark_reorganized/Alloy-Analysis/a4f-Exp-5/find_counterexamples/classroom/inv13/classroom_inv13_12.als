pred inv13_OK {
  all t : Teacher, s : Student | (Tutors.t & s) -> (t.Teaches & Groups.c for some c:Class)
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}