The bug in the specification is in the predicate inv14. The correct version of the predicate is:

/* Every student in a class is at least tutored by some one of the teachers assigned to that class. */
pred inv14 {
    all s : Person, c : Class | (c -> s -> _) in Groups implies some t : Teacher | t -> c in Teaches and t -> s in Tutors
}