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
	Groups : set (Person -> Group)
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
	Teacher in Teaches.Class 
}
/* Every class has teachers assigned. */
pred inv7 {
	// fixed bug: replaced "Class in" with "Class in Groups."
	Class in Groups.Person.Teaches 
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t:Teacher | lone t.Teaches 
}
/* No class has more than a teacher assigned. */
pred inv9 {
	// fixed bug: added "s in" before "Teaches.c"
	all c:Class | lone s in Teaches.c & Teacher 
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all s : Person, c : Class | s in (Teaches.c).Groups 
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

/* Fixed assertion for inv10 */
pred inv10_OK {
  all c:Class, s:Student | some s.(c.Groups) 
}
assert inv10_Repaired {
    inv10[] iff inv10_OK[]
}

/* Fixed assertion names for readability */
assert inv1_OK {
	Person in Student 
}
assert inv2_OK {
	no Teacher 
}
assert inv3_OK {
	no Student & Teacher 
}
assert inv4_OK {
	Person in (Student + Teacher) 
}
assert inv5_OK {
	some Teacher.Teaches 
}
assert inv6_OK {
	Teacher in Teaches.Class 
}
assert inv7_OK {
	Class in Groups.Person.Teaches 
}
assert inv8_OK {
	all t:Teacher | lone t.Teaches 
}
assert inv9_OK {
	all c:Class | lone s in Teaches.c & Teacher 
}
assert inv11_OK {
	all c : Class | (some c.Groups) implies some Teacher & Teaches.c 
}
assert inv12_OK {
	all t : Teacher | some (t.Teaches).Groups 
}
assert inv13_OK {
	Tutors.Person in Teacher and Person.Tutors in Student 
}
assert inv14_OK {
	all s : Person, c : Class, t : Person, g : Group | (c -> s -> g in Groups) and t -> c in Teaches implies t -> s in Tutors 
}
assert inv15_OK {
	all s : Person | some Teacher & ^Tutors.s 
}

/* Verify all assertions */
run check {
	assert inv1_Repaired,
	assert inv2_Repaired,
	assert inv3_Repaired,
	assert inv4_Repaired,
	assert inv5_Repaired,
	assert inv6_Repaired,
	assert inv7_Repaired,
	assert inv8_Repaired,
	assert inv9_Repaired,
	assert inv10_Repaired,
	assert inv11_Repaired,
	assert inv12_Repaired,
	assert inv13_Repaired,
	assert inv14_Repaired,
	assert inv15_Repaired,
	assert inv10_OK,
	assert inv1_OK, 
	assert inv2_OK, 
	assert inv3_OK, 
	assert inv4_OK, 
	assert inv5_OK, 
	assert inv6_OK, 
	assert inv7_OK, 
	assert inv8_OK, 
	assert inv9_OK, 
	assert inv11_OK, 
	assert inv12_OK, 
	assert inv13_OK, 
	assert inv14_OK, 
	assert inv15_OK
} for 1 but exactly 1 Group, 3 Person, 3 Class
