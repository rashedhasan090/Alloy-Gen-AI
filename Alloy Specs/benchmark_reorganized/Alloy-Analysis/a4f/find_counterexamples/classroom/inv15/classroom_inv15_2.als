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
pred inv1_OK {
	Person in Student
}
/* There are no teachers. */
pred inv2_OK {
	no Teacher
}
/* No person is both a student and a teacher. */
pred inv3_OK {
	no Student & Teacher
}
/* No person is neither a student nor a teacher. */
pred inv4_OK {
	Person in Student + Teacher
}
/* There are some classes assigned to teachers. */
pred inv5_OK {
	some Teacher.Teaches
}
/* Every teacher has classes assigned. */
pred inv6_OK {
	all t:Teacher | t.Teaches != none
}
/* Every class has teachers assigned. */
pred inv7_OK {
	all c:Class | Teaches.c != none
}
/* Teachers are assigned at most one class. */
pred inv8_OK {
	all t:Teacher | lone t.Teaches
}
/* No class has more than one teacher assigned. */
pred inv9_OK {
	all c:Class | lone teaches.c
}
/* For every class, every student has a group assigned. */
pred inv10_OK {
	all c:Class, s:Student | some g:Group | (s -> g) in c.Groups
}
/* A class only has groups if it has a teacher assigned. */
pred inv11_OK {
	all c:Class | (some c.Groups) implies some t:Teacher | t.teaches = c   
}
/* Each teacher is responsible for some groups. */
pred inv12_OK {
	all t:Teacher | some g:Group | (t.teaches).(g) in c.groups
}
/* Only teachers tutor, and only students are tutored. */
pred inv13_OK {
	all t:Teacher | t in Tutors
	all s:Student | s in Tutors
	Tutors in Teacher
	Tutors in Student -> Teacher
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14_OK {
	all c:Class, s:Student | some g:Group | (s -> g) in c.Groups implies all t:Teacher | t.teaches = c implies t -> s in Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15_OK {
	all s:Person | some t:Teacher | s in t.^Tutors
}

/* Assertions to verify the correctness of the repaired predicates. */
assert inv1_Repaired {
	inv1[] iff inv1_OK[]
}

assert inv2_Repaired {
	inv2[] iff inv2_OK[]
}

assert inv3_Repaired {
	inv3[] iff inv3_OK[]
}

assert inv4_Repaired {
	inv4[] iff inv4_OK[]
}

assert inv5_Repaired {
	inv5[] iff inv5_OK[]
}

assert inv6_Repaired {
	inv6[] iff inv6_OK[]
}

assert inv7_Repaired {
	inv7[] iff inv7_OK[]
}

assert inv8_Repaired {
	inv8[] iff inv8_OK[]
}

assert inv9_Repaired {
	inv9[] iff inv9_OK[]
}

assert inv10_Repaired {
	inv10[] iff inv10_OK[]
}

assert inv11_Repaired {
	inv11[] iff inv11_OK[]
}

assert inv12_Repaired {
	inv12[] iff inv12_OK[]
}

assert inv13_Repaired {
	inv13[] iff inv13_OK[]
}

assert inv14_Repaired {
	inv14[] iff inv14_OK[]
}

assert inv15_Repaired {
	inv15[] iff inv15_OK[]
}

/* Checking that all assertions hold, indicating that all repaired predicates are correct. */
check inv1_Repaired
check inv2_Repaired
check inv3_Repaired
check inv4_Repaired
check inv5_Repaired
check inv6_Repaired
check inv7_Repaired
check inv8_Repaired
check inv9_Repaired
check inv10_Repaired
check inv11_Repaired
check inv12_Repaired
check inv13_Repaired
check inv14_Repaired
check inv15_Repaired