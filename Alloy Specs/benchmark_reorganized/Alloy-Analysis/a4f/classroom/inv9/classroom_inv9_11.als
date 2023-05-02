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
    some Teacher.Teaches
}
/* Every teacher has classes assigned. */
pred inv6 {
    Teacher.Teaches = Class
}
/* Every class has teachers assigned. */
pred inv7 {
    Teachers.Class = Teacher
}
/* Teachers are assigned at most one class. */
pred inv8 {
    all t: Teacher | lone t.Teaches
}
/* No class has more than a teacher assigned. */
pred inv9 {
    all c: Class | lone teaches.c
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c: Class, s: Student | some s.(c.Groups)
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c: Class | (some c.Groups) implies some t: Teacher | t.Teaches = c 
}
/* Each teacher is responsible for some groups. */
pred inv12 {
    all t: Teacher | some t.Teaches.Groups
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Tutors.Person = Teacher and Person.Tutors = Student
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
    all s: Student, c: Class, g: Group |
        c.Groups[s] = g implies all t: Teacher | t.Teaches = c implies s in t.Tutors[g]
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s: Student | some t: Teacher | s in t.^Tutors
}

/* Fixed predicates */
pred inv7_fixed {
    all c: Class | Teachers[c] in Teacher
}

pred inv9_fixed {
    all c: Class | lone t: Teacher | t.Teaches = c
}

pred inv11_fixed {
    all c: Class | some c.Groups implies some t: Teacher | t.Teaches = c
}

pred inv13_fixed {
    all t: Teacher | t.Tutors = t.~Teaches
}

/* Assertions */
assert inv1_fixed {
    inv1 iff Person in Student
}

assert inv2_fixed {
    inv2 iff no Teacher
}

assert inv3_fixed {
    inv3 iff no Student & Teacher
}

assert inv4_fixed {
    inv4 iff Person in (Student + Teacher)
}

assert inv5_fixed {
    inv5 iff some Teacher.Teaches
}

assert inv6_fixed {
    inv6 iff Teacher.Teaches = Class
}

assert inv7_fixed {
    inv7 iff all c: Class | Teachers[c] in Teacher
}

assert inv8_fixed {
    inv8 iff all t: Teacher | lone t.Teaches
}

assert inv9_fixed {
    inv9 iff all c: Class | lone t: Teacher | t.Teaches = c
}

assert inv10_fixed {
    inv10 iff all c: Class, s: Student | some s.(c.Groups)
}

assert inv11_fixed {
    inv11 iff all c: Class | some c.Groups implies some t: Teacher | t.Teaches = c
}

assert inv12_fixed {
    inv12 iff all t: Teacher | some t.Teaches.Groups
}

assert inv13_fixed {
    inv13 iff all t: Teacher | t.Tutors = t.~Teaches
}

assert inv14_fixed {
    inv14 iff all s: Student, c: Class, g: Group |
    c.Groups[s] = g implies all t: Teacher | t.Teaches = c implies s in t.Tutors[g]
}

assert inv15_fixed {
    inv15 iff all s: Student | some t: Teacher | s in t.^Tutors
}

/* Perfect Oracle */
run inv1_fixed but 1
run inv2_fixed but 1
run inv3_fixed but 1
run inv4_fixed but 1
run inv5_fixed but 1
run inv6_fixed but 1
run inv7_fixed but 1
run inv8_fixed but 1
run inv9_fixed but 1
run inv10_fixed but 1
run inv11_fixed but 1
run inv12_fixed but 1
run inv13_fixed but 1
run inv14_fixed but 1
run inv15_fixed but 1