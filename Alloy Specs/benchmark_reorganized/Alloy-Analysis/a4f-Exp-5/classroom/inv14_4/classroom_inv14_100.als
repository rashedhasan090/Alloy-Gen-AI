pred inv14_OK {
  all s : Student, c : Class, t : Teacher | (all g : Group | c->s->g in Groups) and t in c.Teaches implies t->s in Tutors 
}
assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}