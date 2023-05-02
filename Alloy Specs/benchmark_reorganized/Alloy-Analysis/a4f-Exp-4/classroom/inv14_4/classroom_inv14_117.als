
/* Every student in a class is tutored by all the teachers
   assigned to that class. */
pred inv14 {
    all c: Class, s: Student | 
        all t: Teacher & Teaches.c | s in t.Tutors
}

Here, we need to check that every student in a class is tutored by all the teachers assigned to that class.