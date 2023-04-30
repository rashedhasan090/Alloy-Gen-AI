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
	Groups : Person lone -> Group
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
	Class in Teacher.Teaches 
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t:Teacher | lone t.Teaches 
}
/* No class has more than one teacher assigned. */
pred inv9 {
	all c:Class | lone t:Teacher | t in Teaches.c
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some s.(c.Groups) 
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
 
 all c : Class | some Teacher & Teaches.c implies some c.Groups 
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

/* Repaired assertions */
pred inv1_ok {
	Person in Student
}

pred inv2_ok {
	no Teacher
}

pred inv3_ok {
	no Student & Teacher
}

pred inv4_ok {
	Person in (Student + Teacher)
}

pred inv5_ok {
	some Teacher.Teaches
}

pred inv6_ok {
	Teacher in Teaches.Class
}

pred inv7_ok {
	Class in Teacher.Teaches
}

pred inv8_ok {
	all t : Teacher | lone t.Teaches
}

pred inv9_ok {
	all c : Class | lone t : Teacher | t in Teaches.c
}

pred inv10_ok {
	all c : Class, s : Student | some s.(c.Groups)
}

pred inv11_ok {
	all c : Class | some Teacher & Teaches.c implies some c.Groups
}

pred inv12_ok {
	all t : Teacher | some (t.Teaches).Groups
}

pred inv13_ok {
	Tutors.Person in Teacher and Person.Tutors in Student
}

pred inv14_ok {
	all s : Person, c : Class, t : Person, g : Group | (c -> s -> g in Groups) and t -> c in Teaches implies t -> s in Tutors
}

pred inv15_ok {
	all s : Person | some Teacher & ^Tutors.s
}

assert check_inv1 {
	inv1 iff inv1_ok
}

assert check_inv2 {
	inv2 iff inv2_ok
}

assert check_inv3 {
	inv3 iff inv3_ok
}

assert check_inv4 {
	inv4 iff inv4_ok
}

assert check_inv5 {
	inv5 iff inv5_ok
}

assert check_inv6 {
	inv6 iff inv6_ok
}

assert check_inv7 {
	inv7 iff inv7_ok
}

assert check_inv8 {
	inv8 iff inv8_ok
}

assert check_inv9 {
	inv9 iff inv9_ok
}

assert check_inv10 {
	inv10 iff inv10_ok
}

assert check_inv11 {
	inv11 iff inv11_ok
}

assert check_inv12 {
	inv12 iff inv12_ok
}

assert check_inv13 {
	inv13 iff inv13_ok
}

assert check_inv14 {
	inv14 iff inv14_ok
}

assert check_inv15 {
	inv15 iff inv15_ok
}

check check_inv1
check check_inv2
check check_inv3
check check_inv4
check check_inv5
check check_inv6
check check_inv7
check check_inv8
check check_inv9
check check_inv10
check check_inv11
check check_inv12
check check_inv13
check check_inv14
check check_inv15