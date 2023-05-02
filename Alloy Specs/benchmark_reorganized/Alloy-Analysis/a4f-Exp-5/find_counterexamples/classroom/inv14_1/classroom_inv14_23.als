pred inv14_OK {
  all c:Class , t:Teacher, s:Student, g:Group|(c->s->g in Groups and t->c in Teaches) implies t->s in Tutors
}
assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}