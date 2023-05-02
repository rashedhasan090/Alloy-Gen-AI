
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14_OK {
  all s : Person, c : Class, t : Teacher, g : Group | (c -> s -> g in Groups) and t -> c in Teaches implies s -> t in Tutors
}
assert inv14_Repaired {
  inv14[] iff inv14_OK[]
}
check inv14_Repaired expect 0
