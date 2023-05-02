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
    Groups : Person -> Group
}
/* Some persons are teachers. */
sig Teacher extends Person  {}
/* Some persons are students. */
sig Student extends Person  {}
/* Every person is a student. */
pred inv1 {
    Person in Student ----correct
}
/* There are no teachers. */
pred inv2 {
    no Teacher ----correct
}
/* No person is both a student and a teacher. */
pred inv3 {
    no Student & Teacher ----correct
}
/* No person is neither a student nor a teacher. */
pred inv4 {
    Person in (Student + Teacher) ----correct
}
/* There are some classes assigned to teachers. */
pred inv5 {
    some Teacher.Teaches ----fixed
}
/* Every teacher has classes assigned. */
pred inv6 {
    Teacher.Teaches != none ----fixed
}
/* Every class has teachers assigned. */
pred inv7 {
    all c:Class | c.Teaches != none ----correct
}
/* Teachers are assigned at most one class. */
pred inv8 {
    all t:Teacher | lone t.Teaches ----correct
}
/* No class has more than one teacher assigned. */
pred inv9 {
    all c:Class | lone Teachers.c ----correct
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c:Class, s:Student | some s.(c.Groups) ----correct
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c:Class, g:Group | (some c.Teacher) and (c.Groups.g in Teacher.Teaches.c) ----correct
}
/* Each teacher is responsible for some groups. */
pred inv12 {
    all t:Teacher | some t.Teaches.Groups ----correct
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Tutors.Person in Teacher and Person.Tutors in Student ----correct
}
/* Every student in a class is at least tutored by all the teachers assigned to that class. */
pred inv14 {
    all s:Student, c:Class, t:Teacher, g:Group | (c -> s -> g in Groups) and (t -> c in Teaches) implies (t -> s in Tutors) ----correct
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s:Person | some Teacher & ^Tutors.s ----correct
}

/* ======== IFF PERFECT ORACLE =============== */
pred inv5_OK {
    some Teacher.Teaches ----fixed
}
assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}

pred inv6_OK {
    Teacher.Teaches != none ----fixed
}
assert inv6_Repaired {
    inv6[] iff inv6_OK[]
}

pred inv7_OK {
    all c:Class | c.Teaches != none ----correct
}
assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}

pred inv8_OK {
    all t:Teacher | lone t.Teaches ----correct
}
assert inv8_Repaired {
    inv8[] iff inv8_OK[]
}

pred inv9_OK {
    all c:Class | lone Teachers.c ----correct
}
assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}

pred inv11_OK {
    all c:Class, g:Group | (some c.Teacher) and (c.Groups.g in Teacher.Teaches.c) ----correct
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}

pred inv12_OK {
    all t:Teacher | some t.Teaches.Groups ----correct
}
assert inv12_Repaired {
    inv12[] iff inv12_OK[]
}

---- PerfectOracleCommands
check inv5_Repaired expect 0
check inv6_Repaired expect 0
check inv7_Repaired expect 0
check inv8_Repaired expect 0
check inv9_Repaired expect 0
check inv11_Repaired expect 0
check inv12_Repaired expect 0