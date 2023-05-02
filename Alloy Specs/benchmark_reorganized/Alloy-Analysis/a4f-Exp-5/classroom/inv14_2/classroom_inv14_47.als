fixed code for inv14:

pred inv14_OK {
  all s : Person, c : Class, g : Group | (c -> s -> g in Groups) implies some t : Person | t -> c in Teaches and t -> s in Tutors 
}