Fixed code for pred inv14:

pred inv14_OK {
  all c:Class, s:Student | some t:Teacher | ((c->s) in t.Teaches) implies (s in t.Tutors) 
}