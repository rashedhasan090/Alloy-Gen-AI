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
/* Every person is either a teacher or a student. */
pred inv1 {
    Teacher + Student = Person
}
/* No person is both a student and a teacher. */
pred inv2 {
    no Student & Teacher
}
/* No person is neither a student nor a teacher. */
pred inv3 {
    Student + Teacher = Person
}
/* There are some classes assigned to teachers. */
pred inv4 {
    some Teacher.Teaches
}
/* Every teacher has classes assigned. */
pred inv5 {
    Teacher.Teaches = Class
}
/* Every class has teachers assigned. */
pred inv6 {
    Class in Teacher.Teaches
}
/* Teachers are assigned at most one class. */
pred inv7 {
    all t: Teacher | lone t.Teaches
}
/* No class has more than a teacher assigned. */
pred inv8 {
    all c: Class | loner[c.Groups]
}
/* For every class, every student has a group assigned. */
pred inv9 {
    all c: Class, s: Student | some g: Group | g = c.Groups[s]
}
/* A class only has groups if it has a teacher assigned. */
pred inv10 {
    all c: Class | (some c.Groups) implies some t: Teacher | t.teaches = c
}
/* Each teacher is responsible for some groups. */
pred inv11 {
    all t: Teacher | some g: Group | g in (t.Teaches).Groups
}
/* Only teachers tutor, and only students are tutored. */
pred inv12 {
    Tutors.Person in Teacher and Person.Tutors in Student
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv13 {
    all c: Class, s: Student | some g: Group | g = c.Groups[s] implies all t: Teacher | t.teaches = c implies t.tutors = s
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv14 {
    all s: Student | some Teacher & ^Tutors.s
}
/* Assert all invariants are repaired. */
assert repaired {
    inv1[] and inv2[] and inv3[] and inv4[] and inv5[] and inv6[] and inv7[] and inv8[] and inv9[] and inv10[] and inv11[] and inv12[] and inv13[] and inv14[]
}
/* Check if all assertions are true. */
check repaired