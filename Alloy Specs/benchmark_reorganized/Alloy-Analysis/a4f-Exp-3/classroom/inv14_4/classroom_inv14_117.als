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
	all c:Class | lone t:Teacher | t in c.Teaches 
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some s.(c.Groups) 
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class | (some c.Groups) implies some Teacher & Teaches.c 
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher | some (t.Teaches).Groups 
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all p:Person | p.Tutors in Teacher implies p in Student 
}
/* Every student in a class is tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all c:Class, s:Student | some s.(c.Groups) implies all t:Teacher | t in c.Teaches implies s in t.Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Person | some Teacher & ^Tutors.s
}

/* Repairing the assertion of inv9 */
pred inv9_Repaired {
	all c:Class | lone c.Teaches 
}

/* IFF Perfect Oracle */
pred PerfectOracle {
	inv1_Repaired and
	inv2_Repaired and
	inv3_Repaired and
	inv4_Repaired and
	inv5_Repaired and
	inv6_Repaired and
	inv7_Repaired and
	inv8_Repaired and
	inv9_Repaired and
	inv10_Repaired and
	inv11_Repaired and
	inv12_Repaired and
	inv13_Repaired and
	inv14_Repaired and
	inv15_Repaired
}

/* Repairing the inv14 assertion */
pred repair_pred_1{
	all c:Class, s:Student | some s.(c.Groups) implies all t:Teacher | t in c.Teaches implies s in t.Tutors
}
run repair_pred_1

assert repair_assert_1{
	inv14[] iff repair_pred_1[]
}

check PerfectOracle expect 0