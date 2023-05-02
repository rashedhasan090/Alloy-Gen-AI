pred inv13_OK {
  all t : Teacher | t.Tutors in Student  
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}