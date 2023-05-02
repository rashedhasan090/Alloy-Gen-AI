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
    some c : Class | some t : Teacher | t.teaches = c
}
/* Every teacher has classes assigned. */
pred inv6 {
    all t : Teacher | some c : Class | t.teaches = c
}
/* Every class has teachers assigned. */
pred inv7 {
    all c : Class | some t : Teacher | t.teaches = c
}
/* Teachers are assigned at most one class. */
pred inv8 {
    all t : Teacher | lone c : t.teaches
}
/* No class has more than a teacher assigned. */
pred inv9 {
    all c : Class | lone t : Teacher | t.teaches = c
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c : Class, s : Student | some g : Group | c.groups[s] = g
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c : Class | (some g : c.groups | some t : Teacher | t.teaches = c) implies some t : Teacher | t.teaches = c
}
/* Each teacher is responsible for some groups. */
pred inv12 {
    all t : Teacher | some c : t.teaches | some g : Group | c.groups[t] = g
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    all t : Teacher | t.tutors = none
    all s : Student | s.tutors = none
    all t, s : Person | t.tutors.s implies t in Teacher and s in Student
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
    all c : Class, s : Student | (some g : c.groups | c.groups[s] = g) implies
        all t : Teacher | t.teaches = c implies t.tutors.s
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s : Student | some t : Teacher | s in t.^tutors
}

/* ============= REPAIRS START HERE =============== */

/* All persons are either students or teachers */
pred inv4_OK {
    all p: Person | p in Teacher or p in Student
}
assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}

/* Teacher teaches some class and all classes taught by some teacher */
pred inv5_OK {
    some t : Teacher | some c : Class | t.teaches = c
    all c : Class | some t : Teacher | t.teaches = c
}
assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}

/* A class only has groups if it has a teacher assigned. */
pred inv11_OK {
	all c:Class | some t:Teacher | t.teaches = c implies some c.groups
}
assert inv11_Repaired {
	inv11[] iff inv11_OK[]
}

/* For every class, every student has a group assigned. */
pred inv10_OK {
	all c : Class, s : Student | some g : Group | g in c.groups.s
}
assert inv10_Repaired {
	inv10[] iff inv10_OK[]
}

/* tutoring chain must terminate in a teacher */
pred inv15_OK {
	all p : Person | p in Teacher.*.^Tutors implies p in Teacher
}
assert inv15_Repaired {
	inv15[] iff inv15_OK[]
}

/*
* The following assertions ensure that the repairs are valid.
* Do not modify them.
*/

pred repair_pred_1{inv15[] iff inv15_OK[] }
run repair_pred_1
assert repair_assert_1{inv15[] iff inv15_OK[] }
check repair_assert_1

check inv1_Repaired expect 0
check inv2_Repaired expect 0
check inv3_Repaired expect 0 
check inv4_Repaired expect 0
check inv5_Repaired expect 0
check inv6_Repaired expect 0
check inv7_Repaired expect 0
check inv8_Repaired expect 0
check inv9_Repaired expect 0
check inv10_Repaired expect 0
check inv11_Repaired expect 0
check inv12_Repaired expect 0
check inv13_Repaired expect 0
check inv14_Repaired expect 0
check inv15_Repaired expect 0