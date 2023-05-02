pred inv14_OK {
  all s : Student, c : Class | some t : Teacher | (some g : Group | c->s->g in Groups and g in t.Teaches.Groups) implies t->s in Tutors 
}