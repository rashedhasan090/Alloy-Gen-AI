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
	Teacher.Teaches = Class
}
/* Every class has teachers assigned. */
pred inv7 {
	Class.teachers = Teacher
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t:Teacher | lone t.Teaches
}
/* No class has more than a teacher assigned. */
pred inv9 {
	all c:Class | lone c.teachers
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some s.(c.Groups)
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c:Class | (some c.Groups) implies some Teacher & Teaches.c
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher | some (t.Teaches).Groups
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	Tutors.Person in Teacher and Person.Tutors in Student
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all s : Person, c : Class, t : Person, g : Group | (c -> s -> g in Groups) and t -> c in Teaches implies t -> s in Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Person | some Teacher & ^Tutors.s
}

/*Repair*/

/* Every class has a teacher assigned. */
pred inv7_OK {
	Class.teachers=Tutor
}
assert inv7_Repaired{
	inv7 [] iff inv7_OK[]
}

/*=========IFF PERFECT ORACLE==============*/
pred PerfectOracleAssertions(){
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
	check inv7_Repaired expect 0
}
run PerfectOracleAssertions for 15 but exactly 1 inv7_Repaired, exactly 1 inv1_Repaired, exactly 1 inv2_Repaired, exactly 1 inv3_Repaired, exactly 1 inv4_Repaired, exactly 1 inv5_Repaired, exactly 1 inv6_Repaired, exactly 1 inv8_Repaired, exactly 1 inv9_Repaired, exactly 1 inv10_Repaired, exactly 1 inv11_Repaired, exactly 1 inv12_Repaired, exactly 1 inv13_Repaired, exactly 1 inv14_Repaired, exactly 1 inv15_Repaired
