The bug is in the predicate inv14. The predicate should be fixed by removing the commented line and adding an implication operator between the two conditions.
Fixed code:

/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
    all s : Person, c : Class, t : Person, g : Group | (c -> s -> g in Groups) and t -> c in Teaches implies t -> s in Tutors --fixed
}