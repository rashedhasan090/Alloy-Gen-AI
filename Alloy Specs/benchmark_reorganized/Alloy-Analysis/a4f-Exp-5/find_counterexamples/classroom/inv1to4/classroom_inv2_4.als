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
	some Teacher.Teaches
}
/* Every teacher has classes assigned. */
pred inv6 {
	Teacher.Teaches = Class
}
/* Every class has teachers assigned. */
pred inv7 {
	Class.teachers = Teacher
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t:Teacher | lone t.Teaches
}
/* No class has more than one teacher assigned. */
pred inv9 {
	all c:Class | lone c.teachers
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
	Tutors.Person = Teacher and Person.Tutors = Student
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all s : Person, c : Class, g : Group | (c -> s -> g in Groups) implies all t : Teacher | t -> c in Teaches implies t -> s in Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Person | some Teacher & ^Tutors.s
}

/* IFF PERFECT ORACLE */

pred inv1_fixed {
	Person in Student
}

assert inv1_check {
	inv1[] iff inv1_fixed[]
}

/* Fixed inv2 */
pred inv2_fixed {
	not Teacher.Person
}

assert inv2_check {
	inv2[] iff inv2_fixed[]
}

pred inv3_fixed {
	not (Student & Teacher)
}

assert inv3_check {
	inv3[] iff inv3_fixed[]
}

pred inv4_fixed {
	Person = Student + Teacher
}

assert inv4_check {
	inv4[] iff inv4_fixed[]
}

pred inv5_fixed {
	some Teacher.Teaches
}

assert inv5_check {
	inv5[] iff inv5_fixed[]
}

pred inv6_fixed {
	all t:Teacher | t.Teaches in Class
}

assert inv6_check {
	inv6[] iff inv6_fixed[]
}

pred inv7_fixed {
	all c:Class | c.teachers in Teacher
}

assert inv7_check {
	inv7[] iff inv7_fixed[]
}

pred inv8_fixed {
	all t:Teacher | lone t.Teaches
}

assert inv8_check {
	inv8[] iff inv8_fixed[]
}

pred inv9_fixed {
	all c:Class | lone c.teachers
}

assert inv9_check {
	inv9[] iff inv9_fixed[]
}

pred inv10_fixed {
	all c:Class, s:Student | some g:Group | (c -> s -> g in Groups)
}

assert inv10_check {
	inv10[] iff inv10_fixed[]
}

pred inv11_fixed {
	all c:Class | (some c.Groups) implies some t:Teacher | t.Teaches = c
}

assert inv11_check {
	inv11[] iff inv11_fixed[]
}

pred inv12_fixed {
	all t:Teacher | some g:Group | (t.Teaches -> g in Class.Groups)
}

assert inv12_check {
	inv12[] iff inv12_fixed[]
}

pred inv13_fixed {
	Student.Tutors = Teacher.Person and Person.Tutors = Student
}

assert inv13_check {
	inv13[] iff inv13_fixed[]
}

pred inv14_fixed {
	all c:Class, s:Student, g:Group | (c -> s -> g in Groups) implies all t:Teacher | t -> c in Teaches implies t -> s in Tutors
}

assert inv14_check {
	inv14[] iff inv14_fixed[]
}

pred inv15_fixed {
	all s:Person | some t:Teacher | t in ^Tutors.s
}

assert inv15_check {
	inv15[] iff inv15_fixed[]
}

check inv1_check expect 0
check inv2_check expect 0
check inv3_check expect 0
check inv4_check expect 0
check inv5_check expect 0
check inv6_check expect 0
check inv7_check expect 0
check inv8_check expect 0
check inv9_check expect 0
check inv10_check expect 0
check inv11_check expect 0
check inv12_check expect 0
check inv13_check expect 0
check inv14_check expect 0
check inv15_check expect 0