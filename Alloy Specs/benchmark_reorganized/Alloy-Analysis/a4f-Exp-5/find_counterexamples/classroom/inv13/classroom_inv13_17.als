pred inv13_OK {
  all t:Teacher,s:Student | (s->t not in Tutors) and (t->s not in Tutors)
}