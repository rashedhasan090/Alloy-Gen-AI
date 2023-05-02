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
	Person in Student ----correct
}
/* There are no teachers. */
pred inv2 {
	no Teacher ----correct
}
/* No person is both a student and a teacher. */
pred inv3 {
	no Student & Teacher ----correct
}
/* No person is neither a student nor a teacher. */
pred inv4 {
	Person in (Student + Teacher) ----correct
}
/* There are some classes assigned to teachers. */
pred inv5 {
	some Teacher.Teaches ----correct
}
/* Every teacher has classes assigned. */
pred inv6 {
	Teacher in Teaches.Class ----correct
}
/* Every class has teachers assigned. */
pred inv7 {
	Class in Teacher.Teaches ----correct
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t:Teacher | lone t.Teaches
}
/* No class has more than a teacher assigned. */
pred inv9 {
	all c:Class | lone Teacher & c.Teaches
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some s.(c.Groups)
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
	Tutors.Person in Teacher and Person.Tutors in Student 
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all s : Person, c : Class, t : Person, g : Group | (c -> s -> g in Groups) and t -> c in Teaches implies t -> s in Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Person | some Teacher & ^Tutors.s
}

/* Reapir inv8, 
    Teachers are assigned at most one class. */
pred inv8_OK {
	all t1:Teacher | lone t1.Teaches
}
assert inv8_Repaired {
	inv8[] iff inv8_OK[]
}

/* Repair Perfect Oracle*/
run inv1_OK for 2
run inv2_OK for 2
run inv3_OK for 2
run inv4_OK for 2
run inv5_OK for 2
run inv6_OK for 2
run inv7_OK for 2
run inv8_Repaired for 2
run inv9_OK for 2
run inv10_OK for 2
run inv11_OK for 2
run inv12_OK for 2
run inv13_OK for 2
run inv14_OK for 2
run inv15_OK for 2