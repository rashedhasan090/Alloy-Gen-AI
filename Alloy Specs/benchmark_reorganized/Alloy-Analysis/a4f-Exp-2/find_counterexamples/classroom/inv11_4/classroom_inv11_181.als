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
sig Teacher extends Person {}
/* Some persons are students. */
sig Student extends Person {}
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
	Class in Teacher.Teaches
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t : Teacher | lone t.Teaches
}
/* No class has more than one teacher assigned. */
pred inv9 {
	all c : Class | lone p : Person | p -> c in Teaches and p in Teacher
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c : Class, s : Student | some s.(c.Groups)
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class, p : Person |
		(c -> p -> Group in Groups) implies
		(some t : Teacher | t -> c in Teaches and c -> t -> p -> Group in Groups)
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher | some (t.Teaches).Groups
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	Tutors.Person in Teacher and Tutors.Person in Student
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all c : Class, s : Student | some t : Teacher |
		t -> s in Tutors and
		c -> s -> Group in Groups and
		t -> c in Teaches implies c -> t -> s in Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Person | some Teacher & ^Tutors.s
}

/* Assertions */
assert inv1_ok {
	inv1
}
assert inv2_ok {
	inv2
}
assert inv3_ok {
	inv3
}
assert inv4_ok {
	inv4
}
assert inv5_ok {
	inv5
}
assert inv6_ok {
	inv6
}
assert inv7_ok {
	inv7
}
assert inv8_ok {
	inv8
}
assert inv9_ok {
	inv9
}
assert inv10_ok {
	inv10
}
assert inv11_ok {
	inv11
}
assert inv12_ok {
	inv12
}
assert inv13_ok {
	inv13
}
assert inv14_ok {
	inv14
}
assert inv15_ok {
	inv15
}

/* Repairing the faulty assertion */
pred inv11_fixed {
	all c : Class, p : Person |
		(c -> p -> Group in Groups) implies
		(some t : Teacher, t' : Person | t -> c in Teaches and t' -> c -> p -> Group in Groups and t' in Teacher)
}

/* Assertions with repaired inv11 */
assert inv11_fixed_ok {
	inv11_fixed
}

/* Running all the assertions */
check inv1_ok
check inv2_ok
check inv3_ok
check inv4_ok
check inv5_ok
check inv6_ok
check inv7_ok
check inv8_ok
check inv9_ok
check inv10_ok
check inv11_fixed_ok
check inv12_ok
check inv13_ok
check inv14_ok
check inv15_ok