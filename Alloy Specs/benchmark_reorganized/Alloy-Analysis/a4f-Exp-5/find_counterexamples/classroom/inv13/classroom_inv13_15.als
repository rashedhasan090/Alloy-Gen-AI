pred inv13_OK {
  all t: Teacher, s: Student | (s not in t) implies (s not in t.Tutors)
}

assert inv13_Repaired {
  inv13[] iff inv13_OK[]
}

check inv13_Repaired expect 0