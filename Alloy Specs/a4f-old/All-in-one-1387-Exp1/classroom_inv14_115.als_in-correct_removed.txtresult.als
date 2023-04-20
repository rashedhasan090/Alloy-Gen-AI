The bug is in the predicate inv14. The correct code is:

/* Every student in a class is at least tutored by one teacher assigned to that class. */
pred inv14 {
    all s : Person, c : Class |
    c -> s in Tutors.Person => some t : Teacher |
    t.Teaches = c and t -> s in Tutors
}