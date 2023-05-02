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
/* No class has more than one teacher assigned. */
pred inv9 {
	all c:Class | lone teaches.inv[c]
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some c.Groups[s]
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c:Class | (some c.Groups) implies some t:Teacher | t.teaches.inv[c]
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t:Teacher | some c: t.Teaches | some g:Group | c.Groups[t] = g
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all t:Teacher | t.Tutors = none
	all s:Student | s.Tutors != none
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all s:Student, c:Class | all t:Teacher | t.teaches.inv[c] implies s.tutors in t.Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s:Student | some t:Teacher | t in s.^Tutors
}

/* Create an instance with an error */
one sig University {
	/* Take a teacher and a student */
	teachers : set Teacher,
	students : set Student,
	classes : set Class,
	/* Assign a teacher to a class and a student to that class */
	someTeacher : Teacher -> one classes, 
	someGroup : Person -> one Group,
	groups : set Group,
	/* assign each student to a group */
	assignment : students -> (classes.Groups -> groups) 
}{
	/* Constraints */
	/* Assign some teachers to classes, otherwise inv5 fails */
	all t:teachers | some c:classes | t.teaches.inv[c]
	/* Assign groups only if class has a teacher assigned, otherwise inv11 fails */
	all c:classes | (some c.Groups) implies some t:Teacher | t.teaches.inv[c]
	/* Assign at most one teacher to a class, otherwise inv9 fails */
	all c:classes | lone teaches.inv[c]
	/* Assign each student to a group, otherwise inv10 fails */
	all c:classes, s:students | some groups.(c.Groups[s])
	/* All students should be tutored, otherwise inv13 fails */
	all c:classes, s:students | some Teachers.inv[c].Tutors.s
	/* Assignment should match groups of the class, otherwise inv14 fails */
	all c:classes, s:students | all g:(classes.Groups[s][c]) | g=assignment[s].c.Groups[s]
}