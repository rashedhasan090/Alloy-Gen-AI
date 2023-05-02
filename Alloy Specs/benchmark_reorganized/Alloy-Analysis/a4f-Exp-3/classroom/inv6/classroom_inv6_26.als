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
/* No class has more than one teacher assigned. */
pred inv9 {
	all c:Class | lone t : Teacher | t -> c in c.Teaches 
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some g : Group | g = c.Groups[s]
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class | (some c.Groups) implies some t : Teacher | t -> c in c.Teaches 
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher | some tc : t.Teaches | some g : Group | g = tc.Groups[t]
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all t : Teacher | t.Tutors = t.Teaches.persons 
	all s : Student | s.Tutors = none 
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all c:Class, s:Student | all t : Teacher | (t -> c in c.Teaches) implies t -> s in s.Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Person | some t : Teacher | t in ^s.Tutors
}

/* Repaired Assertions */
pred inv6_OK {
	all t : Teacher | t.Teaches != none 
}
pred inv9_OK {
	all c:Class | lone t : Teacher | t -> c in c.Teaches 
}
pred inv11_OK {
	all c : Class | (some c.Groups) implies some t : Teacher | t -> c in c.Teaches 
}
pred inv13_OK {
	all t : Teacher | t.Tutors = t.Teaches.persons 
	all s : Student | s.Tutors = none 
}

/* Check and Repair Command */
check inv1, inv2, inv3, inv4, inv5, inv6_OK, inv7, inv8, inv9_OK, inv10, inv11_OK, inv12, inv13_OK, inv14, inv15

/* Repair Predicate and Assertion for inv6 */
pred repair_pred_1 {
    inv6[] iff inv6_OK[]
}
run repair_pred_1
assert repair_assert_1 {
    inv6[] iff inv6_OK[]
}
check repair_assert_1