/* Fixed code */

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
    Person in (Student + Teacher)
}
/* There are some classes assigned to teachers. */
pred inv5 {
    some Teacher.teaches
}
/* Every teacher has classes assigned. */
pred inv6 {
    Teacher.teaches = Class
}
/* Every class has teachers assigned. */
pred inv7 {
    Class.teaches = Teacher
}
/* Teachers are assigned at most one class. */
pred inv8 {
    all t: Teacher | lone t.Teaches
}
/* No class has more than one teacher assigned. */
pred inv9 {
    all c: Class | lone c.teaches.Teacher
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c: Class, s: Student | some s.(c.Groups)
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c: Class | (some c.Groups) implies some t: Teacher | t.teaches = c
}
/* Each teacher is responsible for some groups. */
pred inv12 {
    all t: Teacher | some (t.teaches.Groups)
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    all s: Student | s not in Tutors.Person
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
    all s: Person, c: Class, g: Group |
    (
        c -> s -> g in Groups
    ) implies (
        all t: Teacher | t -> c in Teaches implies t -> s in Tutors
    )
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s: Person | some t: Teacher | t in ^s.Tutors
}

/*==============*/

/* Assertions */
assert inv1_Assert {
    inv1
}

assert inv2_Assert {
    inv2
}

assert inv3_Assert {
    inv3
}

assert inv4_Assert {
    inv4
}

assert inv5_Assert {
    inv5
}

assert inv6_Assert {
    inv6
}

assert inv7_Assert {
    inv7
}

assert inv8_Assert {
    inv8
}

assert inv9_Assert {
    inv9
}

assert inv10_Assert {
    inv10
}

assert inv11_Assert {
    inv11
}

assert inv12_Assert {
    inv12
}

assert inv13_Assert {
    inv13
}

assert inv14_Assert {
    inv14
}

assert inv15_Assert {
    inv15
}