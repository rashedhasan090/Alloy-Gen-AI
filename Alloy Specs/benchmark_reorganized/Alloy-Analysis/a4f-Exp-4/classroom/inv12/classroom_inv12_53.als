
/* Each teacher is responsible for some groups. */
pred inv12 {
  all t:Teacher | (some p:Person ,c:Class| t->c in Teaches and c->p->(t.Groups)  
}