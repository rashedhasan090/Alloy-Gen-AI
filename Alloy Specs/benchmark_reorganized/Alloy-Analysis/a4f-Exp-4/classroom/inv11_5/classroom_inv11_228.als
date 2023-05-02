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
	Class in Teaches.Class 
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t:Teacher | lone t.Teaches 
}
/* No class has more than one teacher assigned. */
pred inv9 {
	all c:Class | lone t : Teacher | t -> c in Teaches
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some g:Group | c -> s -> g in Groups
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c:Class | some t:Teacher | t -> c in Teaches implies some g:Group | c -> Person -> g in Groups
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher | some g:Group | (t.Teaches).Groups = g 
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	Tutors in Teacher and Tutors.Person in Student 
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all s : Student, c : Class, g : Group | (c -> s -> g in Groups) implies all t : Teacher | t -> c in Teaches implies t -> s in Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Person | some Teacher & ^Tutors.s
}

/* Recheck alloy scope */
run {inv1 and inv2 and inv3 and inv4 and inv5 and inv6 and inv7 and inv8 and inv9 and inv10 and inv11 and inv12 and inv13 and inv14 and inv15} for 5