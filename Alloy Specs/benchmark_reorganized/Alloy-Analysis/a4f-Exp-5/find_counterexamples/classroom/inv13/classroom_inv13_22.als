pred inv13_OK {
  all t:Teacher,s:Student,c:Class | t->c in Teaches and s->c in Tutors implies t->s in Tutors 
}