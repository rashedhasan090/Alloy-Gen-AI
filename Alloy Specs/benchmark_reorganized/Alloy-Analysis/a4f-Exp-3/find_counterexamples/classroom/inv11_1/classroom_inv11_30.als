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
	Teacher in Teaches
}
/* Every class has teachers assigned. */
pred inv7 {
	all c:Class | some t:Teacher | t in c.Teaches
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
	all c:Class, s:Student | some g:Group | c.Groups[s] = g
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c:Class | some t:Teacher | t in c.Teaches implies some g:Group | c.Groups[t] = g
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t:Teacher | some c:Class, g:Group | t in c.Teaches and c.Groups[t] = g
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	Tutor = Teacher and Tutored = Student
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all c:Class, s:Student | some t:Teacher | t in c.Teaches and c.Groups[s] = c.Groups[t] implies s in t.Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s:Student | some t:Teacher | s in t.^Tutors
}

/*========== IFF PERFECT ORACLE ===============*/
pred inv1_ok {
	Person in Student
}
assert inv1_only {
	inv1 iff inv1_ok
}
pred inv2_ok {
	no Teacher
}
assert inv2_only {
	inv2 iff inv2_ok
}
pred inv3_ok {
	no Student & Teacher
}
assert inv3_only {
	inv3 iff inv3_ok
}
pred inv4_ok {
	Person in (Student + Teacher)
}
assert inv4_only {
	inv4 iff inv4_ok
}
pred inv5_ok {
	some Teacher.Teaches
}
assert inv5_only {
	inv5 iff inv5_ok
}
pred inv6_ok {
	Teacher in Teaches
}
assert inv6_only {
	inv6 iff inv6_ok
}
pred inv7_ok {
	all c:Class | some t:Teacher | t in c.Teaches
}
assert inv7_only {
	inv7 iff inv7_ok
}
pred inv8_ok {
	all t:Teacher | lone t.Teaches
}
assert inv8_only {
	inv8 iff inv8_ok
}
pred inv9_ok {
	all c:Class | lone t:Teacher | t in c.Teaches
}
assert inv9_only {
	inv9 iff inv9_ok
}
pred inv10_ok {
	all c:Class, s:Student | some g:Group | c.Groups[s] = g
}
assert inv10_only {
	inv10 iff inv10_ok
}
pred inv11_ok {
	all c:Class | some t:Teacher, g:Group | t in c.Teaches and c.Groups[t] = g implies c.Groups[g] = t
}
assert inv11_only {
	inv11 iff inv11_ok
}
pred inv12_ok {
	all t:Teacher | some c:Class, g:Group | t in c.Teaches and c.Groups[t] = g
}
assert inv12_only {
	inv12 iff inv12_ok
}
pred inv13_ok {
	Tutor = Teacher and Tutored = Student
}
assert inv13_only {
	inv13 iff inv13_ok
}
pred inv14_ok {
	all c:Class, s:Student | some t:Teacher | t in c.Teaches and c.Groups[s] = c.Groups[t] implies s in t.Tutors
}
assert inv14_only {
	inv14 iff inv14_ok
}
pred inv15_ok {
	all s:Student | some t:Teacher | s in t.^Tutors
}
assert inv15_only {
	inv15 iff inv15_ok
}

check inv1_only
check inv2_only
check inv3_only
check inv4_only
check inv5_only
check inv6_only
check inv7_only
check inv8_only
check inv9_only
check inv10_only
check inv11_only
check inv12_only
check inv13_only
check inv14_only
check inv15_only