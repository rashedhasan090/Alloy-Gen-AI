pred inv13_OK {
  all x, y : Person | x->y in Tutors implies x in Teacher and y in Student  
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}