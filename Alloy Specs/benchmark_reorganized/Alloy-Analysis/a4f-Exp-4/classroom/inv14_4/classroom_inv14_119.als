There is a bug in inv14: the quantification over s and t should be disjoint, so s and t should be qualified with "disj". Additionally, the predicate needs to assert that every student in a class is tutored by all teachers assigned to that class, which requires using the "all" quantifier instead of "some". The repaired predicate inv14_OK is:

/* Every student in a class is tutored by all teachers assigned to that class. */
pred inv14_OK {
  all c : Class, s : Student, g : Group | (c -> s -> g in Groups) implies all t : Teacher | t -> c in Teaches implies t -> s in Tutors
}