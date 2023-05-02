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
	Person = Student + Teacher
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
	all c:Class, s:Student | some g:Group | (c.Groups[s] = g)
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c:Class | (no c.Teaches) or (some c.Groups)
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t:Teacher | some (t.Teaches).Groups
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	Student = Tutors.Person and Teacher = Person & Tutors
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all c:Class, s:Student | all t:(c.Teaches.Teacher) | s in t.Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s:Student | some Teacher & ^s.Tutors
}

/* PerfectOracleCommands */
check inv1 expect 0
check inv2 expect 0
check inv3 expect 0 
check inv4 expect 0
check inv5 expect 0
check inv6 expect 0
check inv7 expect 0
check inv8 expect 0
check inv9 expect 0
check inv10 expect 0
check inv11 expect 0
check inv12 expect 0
check inv13 expect 0
check inv14 expect 0
check inv15 expect 0