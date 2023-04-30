// Fixed code for inv14:
pred inv14_OK {
  all s : Student, c : Class, g : Group | (c -> s -> g in Groups) implies all t : Teacher | t -> c in Teaches implies t -> s in Tutors
}