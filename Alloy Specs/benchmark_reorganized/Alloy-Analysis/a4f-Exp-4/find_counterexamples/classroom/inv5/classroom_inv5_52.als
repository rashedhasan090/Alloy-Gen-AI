Fixed code:

/* The registered persons. */
sig Person {
    /* Each person tutors a set of persons. */
    Tutors: set Person,
    /* Each person teaches a set of classes. */
    Teaches: set Class
}
/* The registered groups. */
sig Group {}
/* The registered classes. */
sig Class {
    /* Each class has a set of persons assigned to a group. */
    Groups: Person -> Group
}
/* Some persons are teachers. */
sig Teacher extends Person {}
/* Some persons are students. */
sig Student extends Person {}
/* Every person is either a student or a teacher. */
pred inv1 {
    Person = Teacher + Student
}
/* There exists at least one teacher. */
pred inv2 {
    some Teacher
}
/* No person is both a student and a teacher. */
pred inv3 {
    disj[Student, Teacher]
}
/* Every person is either a student or a teacher. */
pred inv4 {
    all p: Person | p in Student or p in Teacher
}
/* There is at least one class assigned to a teacher. */
pred inv5 {
    some c: Class | c.Teacher != none
}
/* Every teacher teaches at least one class. */
pred inv6 {
    all t: Teacher | some t.Teaches
}
/* Every class has at least one teacher assigned. */
pred inv7 {
    all c: Class | some c.Teacher
}
/* Teachers are assigned at most one class. */
pred inv8 {
    all t: Teacher | one t.Teaches
}
/* No class has more than one teacher assigned. */
pred inv9 {
    all c: Class | lone c.Teacher
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c: Class, s: Student | some c.Groups.s
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c: Class | (some c.Groups) implies some c.Teacher
}
/* Each teacher is responsible for some groups. */
pred inv12 {
    all t: Teacher | some (t.Groups & t.Teaches)
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    all t: Teacher | all s: Student | s in t.Tutors
}
/* Every student in a class is at least tutored by all the teachers
   assigned to that class. */
pred inv14 {
    all c: Class, s: Student | s in c.Groups.Person.Tutor implies all t: c.Teacher | s in t.Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s: Student | some s.^Tutors & Teacher
}

// Asserts to check if the repaired invariants are equivalent to the original ones
assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}
assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}
assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}
assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}
assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}
assert inv6_Repaired {
    inv6[] iff inv6_OK[]
}
assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}
assert inv8_Repaired {
    inv8[] iff inv8_OK[]
}
assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}
assert inv10_Repaired {
    inv10[] iff inv10_OK[]
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}
assert inv12_Repaired {
    inv12[] iff inv12_OK[]
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}
assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}
assert inv15_Repaired {
    inv15[] iff inv15_OK[]
}

// Command to check if all repaired invariants hold
check inv1_Repaired
check inv2_Repaired
check inv3_Repaired
check inv4_Repaired
check inv5_Repaired
check inv6_Repaired
check inv7_Repaired
check inv8_Repaired
check inv9_Repaired
check inv10_Repaired
check inv11_Repaired
check inv12_Repaired
check inv13_Repaired
check inv14_Repaired
check inv15_Repaired