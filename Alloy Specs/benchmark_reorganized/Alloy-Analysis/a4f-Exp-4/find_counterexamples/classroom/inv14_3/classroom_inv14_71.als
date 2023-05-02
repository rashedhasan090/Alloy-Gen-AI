/* The registered persons. */
sig Person {
    /* Each person tutors a set of persons. */
    Tutors : set Person,
    /* Each person teaches a set of classes. */
    Teaches : set Class
}
/* The registered groups. */
sig Group {}
/* The registered classes. */
sig Class {
    /* Each class has a set of persons assigned to a group. */
    Groups : Person -> Group
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
    some c : Class | some t : Teacher | t.Teaches = c
}
/* Every teacher has classes assigned. */
pred inv6 {
    all t : Teacher | some c : t.Teaches | c.Teaches = t
}
/* Every class has teachers assigned. */
pred inv7 {
    all c : Class | some t : Teacher | t.Teaches = c
}
/* Teachers are assigned at most one class. */
pred inv8 {
    all t : Teacher | lone c : t.Teaches | t.Teaches = c
}
/* No class has more than one teacher assigned. */
pred inv9 {
    all c : Class | lone t : Teacher | t.Teaches = c
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c : Class, s : Student | some p : Person | p.Groups[s] = c.Groups[s]
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c : Class | no c.Groups[] implies some t : Teacher | t.Teaches = c
}
/* Each teacher is responsible for some groups. */
pred inv12 {
    all t : Teacher | some c : t.Teaches | some p : Person | p.Groups.t = c
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    all p : Person | p.Tutors in Teacher and p.Tutors & Student = none
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
    all c : Class, s : Student |
        c.Groups[s] != none implies 
        all t : Teacher |
            t.Teaches = c implies s in t.Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all p : Person | some t : Teacher | t in ^p.Tutors
}

/* Perfect oracle commands */
check inv1
check inv2
check inv3
check inv4
check inv5
check inv6
check inv7
check inv8
check inv9
check inv10
check inv11
check inv12
check inv13
check inv14
check inv15