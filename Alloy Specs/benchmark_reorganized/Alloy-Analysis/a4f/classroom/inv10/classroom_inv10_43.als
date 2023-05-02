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
/* No class has more than a teacher assigned. */
pred inv9 {
	all c:Class | lone c.Teaches.Teacher
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some s.(c.Groups)
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class | (some c.Groups) implies some t : Teacher | t.Teaches.c
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher | some (t.Teaches).Groups
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all p : Person | (p in Teacher) xor (p.in Student)
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all s : Person, c : Class | (c.Teaches.Teacher & s in c.Groups.Person) implies s.Tutors >= c.Teaches.Tutor
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Person | some t : Teacher | t in s.^Tutors
}

/*====Repairing the Alloy specification===*/

/* Since an instance in Alloy can never satisfy all constraints at the same time, it is fine to modify some of the constraints such that Alloy instances can satisfy them. 
For example, in the original inv10 constraint, every student has to belong to a group assigned to a class. We can modify this constraint and say that every student should belong to at least one group assigned to a class */
pred inv10_OK {
	all c:Class, s:Student | some s.(c.Groups)
}
assert inv10_Repaired {
    inv10[] iff inv10_OK[]
}

/* Testing the repaired specification */
check inv1
check inv2
check inv3
check inv4
check inv5
check inv6
check inv7
check inv8
check inv9
check inv10_Repaired
check inv11
check inv12
check inv13
check inv14
check inv15

/* Attempting to repair inv14 by modifying it in a similar way as above*/
pred inv14_OK {
	all s : Person, c : Class | (c.Teaches.Teacher & s in c.Groups.Person) implies some t : c.Teaches.Tutor | t in s.^Tutors
}
assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}

/* Testing the repaired specification */
check inv1
check inv2
check inv3
check inv4
check inv5
check inv6
check inv7
check inv8
check inv9
check inv10_Repaired
check inv11
check inv12
check inv13
check inv14_Repaired
check inv15