pred inv13_OK {
  all t:Teacher,s:Student | (t->s not in Tutors) and (s not in Teacher.Tutors) 
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}