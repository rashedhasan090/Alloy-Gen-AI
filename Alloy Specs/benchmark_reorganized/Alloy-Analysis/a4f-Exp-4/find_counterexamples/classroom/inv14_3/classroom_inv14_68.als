
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14_OK {
    all s : Person, c : Class, t : Person, g : Group | (c -> s -> g in Groups) and t -> c in Teaches implies s -> t in Tutors
}