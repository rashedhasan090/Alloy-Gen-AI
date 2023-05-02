pred inv13_OK {
  all p : Person | (p in Teacher) implies (p.Tutors & Student = none)
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}
check inv13_Repaired expect 0