The bug in inv10 is that it only checks if there is at least one group assigned to a class for every student, without considering if all the groups assigned to a class are actually assigned to students. To fix it, we need to modify the predicate to check that every student in a class is assigned to at least one group assigned to that class by a teacher.

Fixed inv10:

/* For every class, every student is assigned to at least one group assigned by a teacher. */
pred inv10_OK {
    all s : Student, c : Class, t : Teacher, g : Group | (c -> s -> g in Groups) and t -> c in Teaches implies g in (t -> c).Groups
}