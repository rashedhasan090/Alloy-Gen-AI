pred inv14_OK {
  all s:Student, c:Class | all t: Teacher & t.Teaches=c => (s->(_->c)) in t.Tutors
}

assert inv14_Repaired {
  inv14[] iff inv14_OK[]
}

check inv14_Repaired expect 0