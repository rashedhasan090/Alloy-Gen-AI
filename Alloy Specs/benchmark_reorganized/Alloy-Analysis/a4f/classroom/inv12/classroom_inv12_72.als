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
    Groups: (Person -> Group)
}
/* Some persons are teachers. */
sig Teacher extends Person {}
/* Some persons are students. */
sig Student extends Person {}
/* Every person is either a student or teacher. */
pred inv1 {
    Person = Student + Teacher
}
/* There are no teachers. */
pred inv2 {
    no Teacher
}
/* No person is both a student and a teacher. */
pred inv3 {
    (Student & Teacher) = none
}
/* No person is neither a student nor a teacher. */
pred inv4 {
    Person = Student + Teacher
}
/* There are some classes assigned to teachers. */
pred inv5 {
    some c: Class | c.Teaches & Teacher
}
/* Every teacher has classes assigned. */
pred inv6 {
    Teacher = Teaches.Person
}
/* Every class has teachers assigned. */
pred inv7 {
    Class = Teaches.Class
}
/* Teachers are assigned at most one class. */
pred inv8 {
    all t: Teacher | lone t.Teaches
}
/* No class has more than one teacher assigned. */
pred inv9 {
    all c: Class | lone c.Teaches & Teacher
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c: Class, s: Student | some c.(Groups.s)
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c: Class | (some c.Groups) implies some Teacher & Teaches.c
}
/* Each teacher is responsible for some groups. */
pred inv12 {
    all t: Teacher | some (t.Teaches).(Groups.t)
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Tutors.Person = Teacher and Tutors.Person = Student
}
/* Every student in a class is at least tutored by all the teachers
     * assigned to that class. */
pred inv14 {
    all s: Student, c: Class | (some c.Groups).s implies all t: c.Teaches & Teacher | t.Tutors.s
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s: Person | some Teacher & ^Tutors.s
}

/* Repaired assertions */
pred inv1_OK {
    Person = Student
}
assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}

pred inv4_OK {
    Person = Student + Teacher
}
assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}

pred inv7_OK {
    Class = Teacher.Teaches
}
assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}

run {
    check inv1_Repaired expect 0
    check inv4_Repaired expect 0
    check inv7_Repaired expect 0
}