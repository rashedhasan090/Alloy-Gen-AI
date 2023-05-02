Fixed code:

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
	Student in Person 
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
	some c:Class | some t:Teacher | t.teaches = c
}
/* Every teacher has classes assigned. */
pred inv6 {
	all t:Teacher | some c:Class | t.teaches = c
}
/* Every class has teachers assigned. */
pred inv7 {
	all c:Class | some t:Teacher | t.teaches = c
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t:Teacher | lone c:Class | t.teaches = c
}
/* No class has more than a teacher assigned. */
pred inv9 {
	all c:Class | lone t:Teacher | t.teaches = c
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some g:Group | (s -> g) in c.groups
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c:Class | (some g:Group | g in c.groups) implies (some t:Teacher | t.teaches = c)
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t:Teacher | some c:Class | t.teaches = c && some g:Group | g in c.groups && (t -> g) in c.groups
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all p:Person | (p in Student) iff (some t:Teacher | t.tutors=p) 
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all c:Class, s:Student | some t:Teacher | t.teaches=c && (s -> _) in c.groups && (t.tutors -> s) in c.tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all p:Person | some t:Teacher | t.tutors p 
}

run {} for 5
check inv1
check inv2
check inv3
check inv4
check inv5
check inv6
check inv7
check inv8
check inv9
check inv10
check inv11
check inv12
check inv13
check inv14
check inv15