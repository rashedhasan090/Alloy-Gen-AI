
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14_OK {
  all s : Student, c : Class, g : Group | (c -> s -> g in Groups) implies all t : Teacher | t -> c in Teaches implies t -> s in Tutors 
}