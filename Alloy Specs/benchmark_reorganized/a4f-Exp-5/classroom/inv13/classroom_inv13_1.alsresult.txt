pred inv13_OK {
  all p:Person,t:Teacher,s:Student | (s in p.Tutors implies s in Student) and (t in p.Tutors implies t in Teacher)
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}