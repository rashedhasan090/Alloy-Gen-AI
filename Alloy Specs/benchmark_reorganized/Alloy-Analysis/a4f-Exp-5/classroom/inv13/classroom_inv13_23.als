pred inv13_OK {
  all t:Teacher,s:Student,c:Class | t in Teaches.c and s in c.Tutors implies s not in t.Teaches
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}