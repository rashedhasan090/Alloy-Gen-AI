pred inv13_OK {
  all t:Teacher,s:Student,p:Person | (p in t.Tutors implies p in Teacher) and (p in s.Tutors implies p in Student) 
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}