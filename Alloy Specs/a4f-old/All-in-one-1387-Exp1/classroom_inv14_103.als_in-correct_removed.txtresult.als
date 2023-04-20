The bug is in the predicate inv14. The correct code is:

/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
  all s : Student, c : Class | c -> s -> _ in Groups implies all t: Teacher | t -> c in Teaches implies t -> s in Tutors
}