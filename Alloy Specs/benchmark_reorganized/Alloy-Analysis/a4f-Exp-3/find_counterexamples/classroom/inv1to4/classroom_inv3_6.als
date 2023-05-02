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
	no p : Person | (p in Student and p in Teacher) 
}
/* No person is neither a student nor a teacher. */
pred inv4 {
	Person in Student + Teacher 
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
/* No class has more than a teacher assigned. */
pred inv9 {
	all c:Class | lone c.Teaches & Teacher 
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some g:Group | (c.Groups[s] = g) 
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class | (some c.Groups) implies some t: Teacher | t in c.Teaches 
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher | some (t.Teaches).Groups 
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all p:Person | p.Tutors in Teacher and p not in Teacher implies p.Tutors in Student 
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all c : Class, s : Student | (some c.Groups[s]) implies
	all t : Teacher | t in c.Teaches implies (s in t.Tutors)
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Student | some t : Teacher | s in t.^Tutors
}

/* Asserts */
assert inv1_assert {
    inv1
}
assert inv2_assert {
    inv2
}
assert inv3_assert {
    inv3
}
assert inv4_assert {
    inv4
}
assert inv5_assert {
    inv5
}
assert inv6_assert {
    inv6
}
assert inv7_assert {
    inv7
}
assert inv8_assert {
    inv8
}
assert inv9_assert {
    inv9
}
assert inv10_assert {
    inv10
}
assert inv11_assert {
    inv11
}
assert inv12_assert {
    inv12
}
assert inv13_assert {
    inv13
}
assert inv14_assert {
    inv14
}
assert inv15_assert {
    inv15
}
check inv1_assert for 5
check inv2_assert for 5
check inv3_assert for 5
check inv4_assert for 5
check inv5_assert for 5
check inv6_assert for 5
check inv7_assert for 5
check inv8_assert for 5
check inv9_assert for 5
check inv10_assert for 5
check inv11_assert for 5
check inv12_assert for 5
check inv13_assert for 5
check inv14_assert for 5
check inv15_assert for 5