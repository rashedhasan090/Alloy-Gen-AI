
/* Every student in a class is tutored by at least one teacher
   assigned to that class. */
pred inv14 {
    all c: Class, s: Student |
        some t: Teacher & t.Teaches = c and s in t.Tutors
}