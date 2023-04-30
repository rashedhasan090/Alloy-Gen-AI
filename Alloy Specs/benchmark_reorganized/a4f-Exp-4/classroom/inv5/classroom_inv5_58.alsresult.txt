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
/* Every person is a student or a teacher. */
pred inv1 {
	Person = Student + Teacher
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
	some t : Teacher | t.Teaches != none
}
/* Every teacher has classes assigned. */
pred inv6 {
	all t : Teacher | t.Teaches != none
}
/* Every class has teachers assigned. */
pred inv7 {
	all c : Class | Teaches[c] != none
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t : Teacher | lone t.Teaches
}
/* No class has more than one teacher assigned. */
pred inv9 {
	all c : Class | lone t : Teacher | t -> c in Teaches
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c : Class, s : Student | s -> c -> Group in Groups
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class | (some c.Groups) implies some t : Teacher | t -> c in Teaches
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher | some c : t.Teaches | some g : Group | (c -> t -> g) in Groups
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all p : Person | (p in Teacher)  = (p.Tutors in Teacher) and (p in Student) = (p.Tutors in Student)
}
/* Every student in a class is tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all c : Class, s : Student | all t : Teacher | t -> c in Teaches implies s -> c -> t.Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Student | some t : Teacher | s in t.^Tutors
}