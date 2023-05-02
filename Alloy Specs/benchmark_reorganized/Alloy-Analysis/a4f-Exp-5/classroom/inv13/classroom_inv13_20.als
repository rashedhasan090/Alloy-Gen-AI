pred inv13_OK {
  all t:Teacher,s:Student | (s in t.Tutors) implies (s not in Teacher) and (t not in Student) 
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}