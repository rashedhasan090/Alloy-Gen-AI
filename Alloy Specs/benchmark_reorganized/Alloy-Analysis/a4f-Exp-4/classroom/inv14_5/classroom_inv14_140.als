
/* Every student in a class is at least tutored by one of the teachers
 * assigned to that class. */
pred inv14_OK {
  all s:Student,c:Class,g:Group | some t:Teacher | (t->s in Tutors and c->s->g in Groups) implies t->c in Teaches 
}
assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}