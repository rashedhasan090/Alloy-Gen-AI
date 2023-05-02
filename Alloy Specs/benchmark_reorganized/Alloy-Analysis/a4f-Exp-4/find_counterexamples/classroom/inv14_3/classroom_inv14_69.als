
The fixed code for inv14 is:

pred inv14_OK {
  all s : Person, c : Class, t : Person, g : Group | (c -> s -> g in Groups) and (c->g in Groups) and t -> c in Teaches implies t -> s in Tutors 
}