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
	all p:Person | p in Student 
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
	all c:Class | lone (Teaches.c & Teacher) 
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some s.(c.Groups) 
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class | (some c.Groups) implies some t : Teacher | t in Teaches.c 
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher | some g : Group, c : Class | (g in (t.Teaches).Groups) and (c in t.Teaches) and (c.Groups[t] = g)
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all p:Person | (p in Teacher) implies (p.Tutors in Teacher) and (all s : Student | s in p.Tutors)
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all s : Person, c : Class, g : Group | (c -> s -> g in Groups) implies all t : Teacher | t -> c in Teaches implies t -> s in Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Person | some t : Teacher | s in ^Tutors.t
}

/* Corrected assertions */
assert inv1_repaired { inv1[] }
assert inv2_repaired { inv2[] }
assert inv3_repaired { inv3[] }
assert inv4_repaired { inv4[] }
assert inv5_repaired { inv5[] }
assert inv6_repaired { inv6[] }
assert inv7_repaired { inv7[] }
assert inv8_repaired { inv8[] }
assert inv9_repaired { inv9[] }
assert inv10_repaired { inv10[] }
assert inv11_repaired { inv11[] }
assert inv12_repaired { inv12[] }
assert inv13_repaired { inv13[] }
assert inv14_repaired { inv14[] }
assert inv15_repaired { inv15[] }

/* Final Verification */
run inv1_repaired for 3
run inv2_repaired for 3
run inv3_repaired for 3
run inv4_repaired for 3
run inv5_repaired for 3
run inv6_repaired for 3
run inv7_repaired for 3
run inv8_repaired for 3
run inv9_repaired for 3
run inv10_repaired for 3
run inv11_repaired for 3
run inv12_repaired for 3
run inv13_repaired for 3
run inv14_repaired for 3
run inv15_repaired for 3