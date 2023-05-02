/* The registered persons. */
sig Person  {
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
	Person in (Student + Teacher)
}

/* There are some classes assigned to teachers. */
pred inv5 {
	some Teacher.Teaches
}

/* Every teacher has classes assigned. */
pred inv6 {
	all t:Teacher | t.Teaches != none
}

/* Every class has teachers assigned. */
pred inv7 {
	all c:Class | c.Teaches != none
}

/* Teachers are assigned at most one class. */
pred inv8 {
	all t:Teacher | lone t.Teaches
}

/* No class has more than one teacher assigned. */
pred inv9 {
	all c:Class | lone t:Teacher | t->c in Teaches
}

/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some g:Group | c.Groups[s] = g
}

/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c:Class | (some c.Groups) implies some Teacher & Teaches.c
}

/* Each teacher is responsible for some groups. */
pred inv12 {
	all t:Teacher | some c:Class, g:Group | c.Teaches=t and c.Groups[some Person | s.Tutors=t]=g
}

/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all p:Person | (p.Tutors=none and p \in Student) or (p.Tutors!=none and p \in Teacher)
}

/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */ 
pred inv14 {
	all c:Class, s:Student | all t:Teacher | (t->c \in Teaches implies s \in t.Tutors implies s in c.Groups)
}

/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all p:Person | some t:Teacher | t->p in ^Tutors
}

/* ======== PERFECT ORACLE ========== */

pred inv1_OK {
	Person in Student
}
assert inv1_fixed {
	inv1 [] iff inv1_OK []
}

pred inv2_OK {
	no Teacher
}
assert inv2_fixed {
	inv2 [] iff inv2_OK []
}

pred inv3_OK {
	no Student & Teacher
}
assert inv3_fixed {
	inv3 [] iff inv3_OK []
}

pred inv4_OK {
	Person in (Student + Teacher)
}
assert inv4_fixed {
	inv4 [] iff inv4_OK []
}

pred inv5_OK {
	some Teacher.Teaches
}
assert inv5_fixed {
	inv5 [] iff inv5_OK []
}

pred inv6_OK {
	all t:Teacher | t.Teaches != none
}
assert inv6_fixed {
	inv6 [] iff inv6_OK []
}

pred inv7_OK {
	all c:Class | c.Teaches != none
}
assert inv7_fixed {
	inv7 [] iff inv7_OK []
}

pred inv8_OK {
	all t:Teacher | lone t.Teaches
}
assert inv8_fixed {
	inv8 [] iff inv8_OK []
}

pred inv9_OK {
	all c:Class | lone t:Teacher | t->c in Teaches
}
assert inv9_fixed {
	inv9 [] iff inv9_OK []
}

pred inv10_OK {
	all c:Class, s:Student | some g:Group | c.Groups[s] = g
}
assert inv10_fixed {
	inv10 [] iff inv10_OK []
}

pred inv11_OK {
	all c:Class | (some c.Groups) implies some Teacher & Teaches.c
}
assert inv11_fixed {
	inv11 [] iff inv11_OK []
}

pred inv12_OK {
	all t:Teacher | some c:Class, g:Group | c.Teaches=t and c.Groups[some Person | s.Tutors=t]=g
}
assert inv12_fixed {
	inv12 [] iff inv12_OK []
}

pred inv13_OK {
	all p:Person | (p.Tutors=none and p \in Student) or (p.Tutors!=none and p \in Teacher)
}
assert inv13_fixed {
	inv13 [] iff inv13_OK []
}

pred inv14_OK {
	all c:Class, s:Student | all t:Teacher | (t->c \in Teaches implies s \in t.Tutors implies s in c.Groups)
}
assert inv14_fixed {
	inv14 [] iff inv14_OK []
}

pred inv15_OK {
	all p:Person | some t:Teacher | t->p in ^Tutors
}
assert inv15_fixed {
	inv15 [] iff inv15_OK []
}

check inv1_fixed expect 0
check inv2_fixed expect 0
check inv3_fixed expect 0
check inv4_fixed expect 0
check inv5_fixed expect 0
check inv6_fixed expect 0
check inv7_fixed expect 0
check inv8_fixed expect 0
check inv9_fixed expect 0
check inv10_fixed expect 0
check inv11_fixed expect 0
check inv12_fixed expect 0
check inv13_fixed expect 0
check inv14_fixed expect 0
check inv15_fixed expect 0