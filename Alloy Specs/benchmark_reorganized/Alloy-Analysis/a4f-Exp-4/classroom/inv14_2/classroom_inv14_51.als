
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
    all c : Class, s : Student | let t = Teachers.c |
        (s -> c -> _) in Groups implies all t':t | t' -> s in Tutors
}