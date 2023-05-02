
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
  all c : Class, t: Teacher | c->t not in Teaches implies not some s:Student,g:Group | c->s->g in Groups 
}