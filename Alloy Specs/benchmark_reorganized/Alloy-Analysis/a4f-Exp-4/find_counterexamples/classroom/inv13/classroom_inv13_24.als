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
    some Teacher.Teaches
}
/* Every teacher has classes assigned. */
pred inv6 {
    Teacher.Teaches = Class
}
/* Every class has teachers assigned. */
pred inv7 {
    Teacher.Teaches = Class
}
/* Teachers are assigned at most one class. */
pred inv8 {
    all t: Teacher | lone t.Teaches
}
/* No class has more than a teacher assigned. */
pred inv9 {
    all c: Class | #((Teaches.c).Tutors) <= 1
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c: Class, s: Student | some (c.Groups).(s.Tutors)
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
    all t: Teacher, s: Student, p: Person | p not in t.Tutors and s not in p.Tutors
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
    all c: Class, s: Student | all t: Teacher | (t.Teaches = c) implies (s.Tutors in c.Groups.(t.Tutors))
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s: Person | some t: Teacher | t in ^s.Tutors
}

/*======== IFF PERFECT ORACLE ===============*/
/* repairs the buggy inv4. */
pred inv4_rep {
    inv4 = (Person = Student + Teacher)
}
assert inv4_ok {
    inv4 iff inv4_rep
}

check inv1, inv2, inv3, inv4_ok, inv5, inv6, inv7, inv8, inv9, inv10, inv11, inv12, inv13, inv14, inv15
```