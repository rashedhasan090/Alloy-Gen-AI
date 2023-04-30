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
sig Class  {
	/* Each class has a set of persons assigned to a group. */
	Groups : Person -> Group
}
/* Some persons are teachers. */
sig Teacher extends Person  {}
/* Some persons are students. */
sig Student extends Person  {}
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
	Teacher in Teaches.Class 
}
/* Every class has teachers assigned. */
pred inv7 {
	Class in Teacher.Teaches 
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t:Teacher | lone t.Teaches 
}
/* No class has more than one teacher assigned. */
pred inv9 {
	all c:Class | lone Teaches[c] 
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some s.(c.Groups) 
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class | (some c.Groups) implies some t : Teacher & t.Teaches = c 
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher | some (t.Teaches).Groups 
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all t: Teacher | t.Tutors = Person & all s: Student | s.Tutors in Teacher
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all c:Class, s:Student | s in c.Groups.(Teacher.Tutors)
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Person | some Teacher & ^Tutors.s
}

/* ============ REPAIRS ===============*/

/* Update inv9 to correctly reference the Teachers relationship */
pred inv9_fixed {
	all c:Class | lone Teachers[c] 
}

/* Fix the class tutor relationship from inv13 */
pred inv13_fixed {
	all t: Teacher | t.Tutors = t.Teaches.Person & all s: Student | s.Tutors in Teacher
}

/* Update inv14 to correctly reference the Teachers relationship */
pred inv14_fixed {
	all c:Class, s:Student | s in c.Groups.(c.Teachers.Tutors)
}

/*========== ASSERTIONS ==========*/

/* Assertion inv9_repaired*/
assert inv9_Repaired {
	inv9[] iff inv9_fixed[]
}

/* Assertion inv13_repaired*/
assert inv13_Repaired {
	inv13[] iff inv13_fixed[]
}

/* Assertion inv14_repaired*/
assert inv14_Repaired {
	inv14[] iff inv14_fixed[]
}

/* ========== CHECKS =========== */

/* Check all the assertions */
check inv1, inv2, inv3, inv4, inv5, inv6, inv7, inv8, inv9_Repaired, inv10, inv11, inv12, inv13_Repaired, inv14_Repaired, inv15

/* Repair inv14 and recheck it */
check inv14_Repaired repairedBy inv14_fixed

/* Repair inv13 and recheck it */
check inv13_Repaired repairedBy inv13_fixed

/* Repair inv9 and recheck it */
check inv9_Repaired repairedBy inv9_fixed