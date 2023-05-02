pred inv14_OK {
  all s:Student,c:Class|some t:Teacher | t->c in Teaches and 
  s->c in (t.Tutors).Groups
}
assert inv14_Repaired {
  inv14[] iff inv14_OK[]
}