pred inv13_OK {
  all p:Person,t:Teacher,s:Student | (s in p.Tutors implies t in s.Teaches) and (t in p.Tutors implies s in t.Teaches) and (p.Teaches = none)
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}