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
	Person = Student + Teacher
}

/* There are some classes assigned to teachers. */
pred inv5 {
	Teacher.Teaches != none
}

/* Every teacher has classes assigned. */
pred inv6 {
	all t: Teacher | t.Teaches != none
}

/* Every class has teachers assigned. */
pred inv7 {
	all c: Class | c.Teaches != none
}

/* Teachers are assigned at most one class. */
pred inv8 {
	all t: Teacher | lone t.Teaches
}

/* No class has more than a teacher assigned. */
pred inv9 {
	all c: Class | lone c.Teaches.Teacher
}

/* For every class, every student has a group assigned. */
pred inv10 {
	all c: Class, s: Student | some g: c.Groups.s
}

/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c: Class | (some c.Groups) implies some t: c.Teaches | t in Teacher
}

/* Each teacher is responsible for some groups. */
pred inv12 {
	all t: Teacher | some c: t.Teaches | some g: c.Groups.t
}

/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all t: Teacher | t.Tutors in Teacher
	all s: Student | s.Tutors in Student
}

/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all c: Class, s: Student | some t: c.Teaches.Teacher | s in t.^Tutors and s in c.Groups.t
}

/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s: Person | some t: Teacher | t in s.^Tutors
}

/* Assertions that check the repaired invariants*/
assert inv1_Repaired {
	inv1[] iff Person in Student
}
assert inv2_Repaired {
	inv2[] iff no Teacher
}
assert inv3_Repaired {
	inv3[] iff no Student & Teacher
}
assert inv4_Repaired {
	inv4[] iff Person = Student + Teacher
}
assert inv5_Repaired {
	inv5[] iff Teacher.Teaches != none
}
assert inv6_Repaired {
	inv6[] iff all t: Teacher | t.Teaches != none
}
assert inv7_Repaired {
	inv7[] iff all c: Class | c.Teaches != none
}
assert inv8_Repaired {
	inv8[] iff all t: Teacher | lone t.Teaches
}
assert inv9_Repaired {
	inv9[] iff all c: Class | lone c.Teaches.Teacher
}
assert inv10_Repaired {
	inv10[] iff all c: Class, s: Student | some g: c.Groups.s
}
assert inv11_Repaired {
	inv11[] iff all c: Class | (some c.Groups) implies some t: c.Teaches.Teacher
}
assert inv12_Repaired {
	inv12[] iff all t: Teacher | some c: t.Teaches | some g: c.Groups.t
}
assert inv13_Repaired {
	inv13[] iff all t: Teacher | t.Tutors in Teacher and all s: Student | s.Tutors in Student
}
assert inv14_Repaired {
	inv14[] iff all c: Class, s: Student | some t: c.Teaches.Teacher | s in t.^Tutors and s in c.Groups.t
}
assert inv15_Repaired {
	inv15[] iff all s: Person | some t: Teacher | t in s.^Tutors
}

run {
	check inv1_Repaired
	check inv2_Repaired
	check inv3_Repaired
	check inv4_Repaired
	check inv5_Repaired
	check inv6_Repaired
	check inv7_Repaired
	check inv8_Repaired
	check inv9_Repaired
	check inv10_Repaired
	check inv11_Repaired
	check inv12_Repaired
	check inv13_Repaired
	check inv14_Repaired
	check inv15_Repaired
} for 5 but exactly 5 Group, 5 Class, 10 Person, 4 Teacher, 6 Student