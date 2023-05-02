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
	some c : Class | some Teacher & Teaches.c
}
/* Every teacher has classes assigned. */
pred inv6 {
	all t : Teacher | some c : t.Teaches | c in Class
}
/* Every class has teachers assigned. */
pred inv7 {
	all c : Class | some t : Teacher & t.Teaches = c
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t : Teacher | lone t.Teaches 
}
/* No class has more than a teacher assigned. */
pred inv9 {
	all c : Class | #Teaches.c <= 1
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c : Class, s : Student | some g : c.Groups | g in Group
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class | (some c.Groups) implies some Teacher & Teaches.c 
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher | some c : t.Teaches | some g : c.Groups | g in Group
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all p : Person | p.Tutors in Teacher iff p in Teacher else p.Tutors in Student
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all c : Class, s : Student | 
		s in c.Groups.g and g in Group implies 
			all t : Teacher | t.Teaches.c implies s in t.Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Student | some t : Teacher & ^s.Tutors = t
}

/* Assertions */
assert inv1Assertion {
	check inv1
}
assert inv2Assertion {
	check inv2
}
assert inv3Assertion {
	check inv3
}
assert inv4Assertion {
	check inv4
}
assert inv5Assertion {
	check inv5
}
assert inv6Assertion {
	check inv6
}
assert inv7Assertion {
	check inv7
}
assert inv8Assertion {
	check inv8
}
assert inv9Assertion {
	check inv9
}
assert inv10Assertion {
	check inv10
}
assert inv11Assertion {
	check inv11
}
assert inv12Assertion {
	check inv12
}
assert inv13Assertion {
	check inv13
}
assert inv14Assertion {
	check inv14
}
assert inv15Assertion {
	check inv15
}