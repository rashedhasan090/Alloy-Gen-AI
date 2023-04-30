There is a bug in the original inv14 predicate. The fixed predicate is provided below.

/* Every student in a class is tutored by all the teachers assigned to that class. */
pred inv14_OK {
  all s:Student, c:Class|some t:Teacher |
    t->c in Teaches and some s.(c.Groups) implies
      all t':Teacher | t'->c in Teaches implies t' in s.^Tutors 
}