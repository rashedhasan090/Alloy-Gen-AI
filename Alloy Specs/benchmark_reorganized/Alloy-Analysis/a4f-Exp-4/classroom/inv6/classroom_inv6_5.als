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
    Person = Student + Teacher
}
/* There are some classes assigned to teachers. */
pred inv5 {
    some t: Teacher | t.Teaches != none
}
/* Every teacher has classes assigned. */
pred inv6 {
    all t: Teacher | t.Teaches != none implies t in Teaches
}
/* Every class has teachers assigned. */
pred inv7 {
    all c: Class | c.Teaches != none
}
/* Teachers are assigned at most one class. */
pred inv8 {
    all t: Teacher | lone t.Teaches
}
/* No class has more than one teacher assigned. */
pred inv9 {
    all c: Class | lone c.Teaches.Teacher
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c: Class, s: Student | some g: Group | s in c.Groups.g
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c: Class | c.Groups != none implies c.Teaches != none
}
/* Each teacher is responsible for some groups. */
pred inv12 {
    all t: Teacher | some c: t.Teaches | some g: Group | c.Groups.t = g
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    all t: Teacher | t.Tutors = none
    all s: Student | s.Tutors.Person = none
}
/* Every student in a class is tutored by all the teachers
 * assigned to that class. */
pred inv14 {
    all c: Class, s: Student | all t: c.Teaches.Teacher | s in t.Tutors.s
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s: Person | some t: Teacher | s in t.^Tutors
}

/* Assertions and checks */
assert inv1_OK {
    Person in Student
}
assert inv2_OK {
    no Teacher
}
assert inv3_OK {
    no Student & Teacher
}
assert inv4_OK {
    Person = Student + Teacher
}
assert inv5_OK {
    some t: Teacher | t.Teaches != none
}
assert inv6_OK {
    all t: Teacher | t.Teaches != none implies t in Teaches
}
assert inv7_OK {
    all c: Class | c.Teaches != none
}
assert inv8_OK {
    all t: Teacher | lone t.Teaches
}
assert inv9_OK {
    all c: Class | lone c.Teaches.Teacher
}
assert inv10_OK {
    all c: Class, s: Student | some g: Group | s in c.Groups.g
}
assert inv11_OK {
    all c: Class | c.Groups != none implies c.Teaches != none
}
assert inv12_OK {
    all t: Teacher | some c: t.Teaches | some g: Group | c.Groups.t = g
}
assert inv13_OK {
    all t: Teacher | t.Tutors = none
    all s: Student | s.Tutors.Person = none
}
assert inv14_OK {
    all c: Class, s: Student | all t: c.Teaches.Teacher | s in t.Tutors.s
}
assert inv15_OK {
    all s: Person | some t: Teacher | s in t.^Tutors
}

run inv1_OK for 3
run inv2_OK for 3
run inv3_OK for 3
run inv4_OK for 3
run inv5_OK for 3
run inv6_OK for 3
run inv7_OK for 3
run inv8_OK for 3
run inv9_OK for 3
run inv10_OK for 3
run inv11_OK for 3
run inv12_OK for 3
run inv13_OK for 3
run inv14_OK for 3
run inv15_OK for 3