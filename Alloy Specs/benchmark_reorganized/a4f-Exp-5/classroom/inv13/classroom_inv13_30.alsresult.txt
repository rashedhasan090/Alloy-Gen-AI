pred inv13_OK {
  Tutors.Person in Teacher and Tutors.Person in Student.Teaches 
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}