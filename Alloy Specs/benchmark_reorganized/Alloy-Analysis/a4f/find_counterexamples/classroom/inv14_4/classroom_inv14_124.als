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
/* No class has more than a teacher assigned. */
pred inv9 {
	all c:Class | lone c.Teaches.Teacher
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some g:Group | (s -> g) in c.Groups
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
	all p : Person |
		(p in Teacher) iff (p.Tutors != none) and
		(p in Student) iff (p.Tutors = none)
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all c : Class, s : Student |
		(s in c.Groups.Person) implies
			all t : Teacher |
				t in c.Teaches and s in t.Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Person |
		s.Tutors & Teacher != none
}
/* PerfectOracleCommands */
run inv1 for exactly 1 Person, 1 Group, 1 Class, 1 Student, 0 Teacher
run inv2 for exactly 1 Person, 1 Group, 1 Class, 1 Student, 0 Teacher
run inv3 for exactly 1 Person, 1 Group, 1 Class, 1 Student, 0 Teacher
run inv4 for exactly 1 Person, 1 Group, 1 Class, 1 Student, 0 Teacher
run inv5 for exactly 1 Person, 1 Group, 1 Class, 1 Student, 1 Teacher
run inv6 for exactly 1 Person, 1 Group, 1 Class, 1 Student, 1 Teacher
run inv7 for exactly 1 Person, 1 Group, 1 Class, 1 Student, 1 Teacher
run inv8 for exactly 1 Person, 1 Group, 1 Class, 1 Student, 1 Teacher
run inv9 for exactly 1 Person, 1 Group, 1 Class, 1 Student, 1 Teacher
run inv10 for exactly 1 Person, 1 Group, 1 Class, 2 Student, 1 Teacher
run inv11 for exactly 1 Person, 1 Group, 1 Class, 2 Student, 1 Teacher
run inv12 for exactly 1 Person, 1 Group, 1 Class, 2 Student, 2 Teacher
run inv13 for exactly 1 Person, 1 Group, 1 Class, 2 Student, 2 Teacher
run inv14 for exactly 1 Person, 1 Group, 1 Class, 2 Student, 2 Teacher
run inv15 for exactly 1 Person, 1 Group, 1 Class, 2 Student, 2 Teacher