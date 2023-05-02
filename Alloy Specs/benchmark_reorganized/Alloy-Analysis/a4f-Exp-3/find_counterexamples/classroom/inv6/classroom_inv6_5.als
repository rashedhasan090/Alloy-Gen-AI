/* Fixed Alloy specification */

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
    Person = Student + Teacher
}

/* There are no teachers who do not teach any classes. */
pred inv2 {
    Teacher.Teaches != none
}

/* No person is both a student and a teacher. */
pred inv3 {
    disj[Student, Teacher]
}

/* No person is neither a student nor a teacher. */
pred inv4 {
    Person = Student + Teacher
}

/* There are no classes with no teachers assigned. */
pred inv5 {
    Class = Teacher.Teaches
}

/* Every teacher teaches at least one class. */
pred inv6 {
    all t: Teacher | t.Teaches != none
}

/* Every class has at least one teacher assigned. */
pred inv7 {
    all c: Class | c.Teaches != none
}

/* Teachers are assigned at most one class. */
pred inv8 {
    all t: Teacher | lone t.Teaches
}

/* No class has more than one teacher assigned. */
pred inv9 {
    all c: Class | lone c.Teaches[].Teacher
}

/* For every class, every student has a group assigned. */
pred inv10 {
    all c: Class, s: Student | some g: c.Groups.s
}

/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c: Class | (some c.Groups[]) => (some t: Teacher | t.Teaches = c)
}

/* Each teacher is responsible for some groups. */
pred inv12 {
    all t: Teacher | some g: t.Teaches.Groups
}

/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    all t: Teacher, s: Student | t.Tutors = none && s.Tutors != none
}

/* Every student in a class is tutored by one of the teachers assigned to that class. */
pred inv14 {
    all c: Class, s: Student |some t: c.Teaches | t.Tutors = s.Tutors
}

/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s: Student | some t: Teacher | s.Tutors = t.*(Tutors)
}

/* Assertions */

assert inv1_ok {
    inv1
}

assert inv2_ok {
    inv2
}

assert inv3_ok {
    inv3
}

assert inv4_ok {
    inv4
}

assert inv5_ok {
    inv5
}

assert inv6_ok {
    inv6
}

assert inv7_ok {
    inv7
}

assert inv8_ok {
    inv8
}

assert inv9_ok {
    inv9
}

assert inv10_ok {
    inv10
}

assert inv11_ok {
    inv11
}

assert inv12_ok {
    inv12
}

assert inv13_ok {
    inv13
}

assert inv14_ok {
    inv14
}

assert inv15_ok {
    inv15
}

check inv1_ok
check inv2_ok
check inv3_ok
check inv4_ok
check inv5_ok
check inv6_ok
check inv7_ok
check inv8_ok
check inv9_ok
check inv10_ok
check inv11_ok
check inv12_ok
check inv13_ok
check inv14_ok
check inv15_ok