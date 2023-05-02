
pred inv14_OK {
  all c:Class, s:Student, g:Group, t:Teacher | (c->s->g in Groups and t->c in Teaches) implies t->s in Tutors 
}