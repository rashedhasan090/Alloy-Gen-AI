The bug in the specification is in predicate inv15. The commented out line should be replaced by the corrected line below:

/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s : Person | some Teacher & ^s.Tutors --corrected
}