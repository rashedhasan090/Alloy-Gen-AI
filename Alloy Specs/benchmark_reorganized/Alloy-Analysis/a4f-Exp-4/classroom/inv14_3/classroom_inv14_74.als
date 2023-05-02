
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
  all c : Class, s : Student |
    some s.(c.Groups) implies
      all t : Teacher |
        t -> c in Teaches implies t -> s in Tutors  
}