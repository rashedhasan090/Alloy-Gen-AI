
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
    all c: Class, s: Student | some p: Person, g: Group |
        c->s->g in Groups &&
        p in Teacher.Teaches.c &&
        s in p.Tutors.g
}