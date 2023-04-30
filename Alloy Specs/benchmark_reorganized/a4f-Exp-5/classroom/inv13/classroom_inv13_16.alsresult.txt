pred inv13_OK {
  all t:Teacher, s:Student | (t.Teaches & s.Teaches) implies t->s in Tutors and s->t not in Tutors 
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}