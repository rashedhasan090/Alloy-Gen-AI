The bug in the specification is in the predicate inv14, where the implication is incorrect. The corrected predicate is:

/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
    all s : Person, c : Class | c -> s in Tutors => (Tutors.c & Teacher) in s.Tutors
}