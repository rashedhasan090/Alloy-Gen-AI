The bug in the specification is in the predicate inv15. The correct version should be as follows:

/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
  all s : Person | some Teacher & ^s.Tutors --correct
}