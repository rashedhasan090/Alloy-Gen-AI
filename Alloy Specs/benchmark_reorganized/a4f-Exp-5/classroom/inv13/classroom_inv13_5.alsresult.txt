pred inv13_OK {
  all s:Student, t:Teacher | s not in t.Tutors 
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}