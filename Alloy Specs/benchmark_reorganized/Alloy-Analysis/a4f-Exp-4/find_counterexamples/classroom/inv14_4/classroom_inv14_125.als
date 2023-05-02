
pred inv14_OK {
  all s:Student, c:Class, g:Group | (c->g in Groups) implies all t:(Teacher & c->t.Teaches) | g in t.Tutors.s
}