/* The registered persons. */
sig Person  {
    /* Each person tutors a set of persons. */
    Tutors : set Person,
    /* Each person teaches a set of classes. */
    Teaches : set Class
}

/* The registered groups. */
sig Group {}

/* The registered classes. */
sig Class  {
    /* Each class has a set of persons assigned to a group. */
    Groups : Person -> Group,
    /* Some classes are assigned to teachers. */
    Assigned : set Teacher,
    /* The set of persons who teach this class. */
    Teachers : Assigned->Person
}

/* Some persons are teachers. */
sig Teacher extends Person {}

/* Some persons are students. */
sig Student extends Person {}

/* Every person is a student. */
pred inv1 {
    Person in Student
}

/* There are no teachers. */
pred inv2 {
    no Teacher
}

/* No person is both a student and a teacher. */
pred inv3 {
    no Student & Teacher
}

/* No person is neither a student nor a teacher. */
pred inv4 {
    Person in (Student + Teacher)
}

/* No class has more than one teacher assigned. */
pred inv5 {
    all c:Class | lone Teaches.c.Teachers
}

/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv6 {
    all s : Person, c : Class | c->s in Groups implies
    all t : c.Teachers | t -> s in Tutors
}

/* Only teachers tutor, and only students are tutored. */
pred inv7 {
    Tutors.Person in Teacher and Person.Tutors in Student
}

/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv8 {
    all s : Person | some Teacher & ^Tutors.s
}

/* Assertions to check the invariants */

pred inv1_OK {
    Person in Student
}

assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}

pred inv2_OK {
    no Teacher
}

assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}

pred inv3_OK {
    no Student & Teacher
}

assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}

pred inv4_OK {
    Person in (Student + Teacher)
}

assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}

pred inv5_OK {
    all c:Class | lone Teaches.c.Teachers
}

assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}

pred inv6_OK {
    all s : Person, c : Class | c->s in Groups implies
    all t : c.Teachers | t -> s in Tutors
}

assert inv6_Repaired {
    inv6[] iff inv6_OK[]
}

pred inv7_OK {
    Tutors.Person in Teacher and Person.Tutors in Student
}

assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}

pred inv8_OK {
    all s : Person | some Teacher & ^Tutors.s
}

assert inv8_Repaired {
    inv8[] iff inv8_OK[]
}

/* PerfectOracleCommands */
check inv1_Repaired expect 0
check inv2_Repaired expect 0
check inv3_Repaired expect 0 
check inv4_Repaired expect 0
check inv5_Repaired expect 0
check inv6_Repaired expect 0
check inv7_Repaired expect 0
check inv8_Repaired expect 0

pred repair_pred_1{inv12[] iff some t : Teacher | some (t.Teaches).Groups}
run repair_pred_1

assert repair_assert_1{inv12[] iff some t : Teacher | some (t.Teaches).Groups}
check repair_assert_1