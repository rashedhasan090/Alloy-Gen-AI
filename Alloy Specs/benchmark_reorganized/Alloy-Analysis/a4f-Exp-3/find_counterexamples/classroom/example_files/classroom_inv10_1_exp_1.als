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
assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}
/* There are no teachers. */
pred inv2_OK {
	no Teacher 
}
assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}
/* No person is both a student and a teacher. */
pred inv3_OK {
	no Student & Teacher 
}
assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}
/* No person is neither a student nor a teacher. */
pred inv4_OK {
	Person in (Student + Teacher) 
}
assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}
/* There are some classes assigned to teachers. */
pred inv5_OK {
	some Teacher.Teaches 
}
assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}
/* Every teacher has classes assigned. */
pred inv6_OK {
	Teacher in Teaches
}
assert inv6_Repaired {
    inv6[] iff inv6_OK[]
}
/* Every class has teachers assigned. */
pred inv7_OK {
	Class in Teacher.Teaches 
}
assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}
/* Teachers are assigned at most one class. */
pred inv8_OK {
	all t:Teacher | lone t.Teaches 
}
assert inv8_Repaired {
    inv8[] iff inv8_OK[]
}
/* No class has more than a teacher assigned. */
pred inv9_OK {
	all c:Class | lone Teaches[c] & Teacher 
}
assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}
/* For every class, every student has a group assigned. */
pred inv10_OK {
	all c:Class, s:Student | some c.Groups.s
}
assert inv10_Repaired {
    inv10[] iff inv10_OK[]
}
/* A class only has groups if it has a teacher assigned. */
pred inv11_OK {
	all c : Class | (some c.Groups) implies some t:Teacher | t in c.Teaches
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}
/* Each teacher is responsible for some groups. */
pred inv12_OK {
	all t : Teacher | some (t.Teaches.Groups) 
}
assert inv12_Repaired {
    inv12[] iff inv12_OK[]
}
/* Only teachers tutor, and only students are tutored. */
pred inv13_OK {
	Tutors.Person in Teacher and Person -- Teacher in Tutors.Student 
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14_OK {
	all s : Student, c : Class, g : Group |
		(s in (Class.Groups[c]).Person) implies
		all t : (Teacher & Teaches[c]) |
			s in t.Tutors[g]
}
assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15_OK {
	all s : Person | some Teacher & ^s.Tutors 
}
assert inv15_Repaired {
    inv15[] iff inv15_OK[]
}

------ PerfectOracleCommands
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