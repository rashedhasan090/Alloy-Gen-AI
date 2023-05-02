pred inv13_OK {
  all t1:Teacher,t2:Teacher,s:Student | s->t1 not in Tutors and t1!=t2 implies t1->t2 not in Tutors 
}