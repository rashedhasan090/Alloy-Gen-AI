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
	Teacher.Teaches = Class 
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
	all c:Class | lone Teaches.c & Teacher 
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some s.(c.Groups) 
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c:Class,g:Group | some c.Teacher.(c.Groups.g) 
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

/* ===================================== */
/* New assertions to test repaired model */
/* ===================================== */

/* For every class, there is at least one group. */
pred inv16 {
	all c : Class | some c.Groups
}

/* For every student, there is at least one class. */
pred inv17 {
	all s : Student | some s.Teaches
}

/* Each class is taught by at least one teacher. */
pred inv18 {
	all c : Class | some t : Teacher | t.Teaches = c
}

/* Each group is assigned to at most one person (teacher or student) per class. */
pred inv19 {
	all c : Class, g : Group | lone c.Groups.g
}

/* Each person teaches or tutors at most one class. */
pred inv20 {
	all p : Person |
		lone c : Class |
			c in p.Teaches + p.Tutors
}

/* There is no student that is assigned to a group without a teacher assigned to that group in the same class. */
pred inv21 {
	no s:Student, c:Class, g:Group | g !in c.Groups.s => no Teacher.(c -> g)
}

/* There is no person that teaches or tutors any class if he/she is not assigned to at least one group in that class. */
pred inv22 {
	no p:Person, c:Class | p !in c.Tutors + c.Teaches
}

/* PerfectOracleCommands */
assert inv1_Repaired {
	inv1[] iff inv1_OK[]
}
assert inv2_Repaired {
	inv2[] iff inv2_OK[]
}
assert inv3_Repaired {
	inv3[] iff inv3_OK[]
}
assert inv4_Repaired {
	inv4[] iff inv4_OK[]
}
assert inv5_Repaired {
	inv5[] iff inv5_OK[]
}
assert inv6_Repaired {
	inv6[] iff inv6_OK[]
}
assert inv7_Repaired {
	inv7[] iff inv7_OK[]
}
assert inv8_Repaired {
	inv8[] iff inv8_OK[]
}
assert inv9_Repaired {
	inv9[] iff inv9_OK[]
}
assert inv10_Repaired {
	inv10[] iff inv10_OK[]
}
assert inv11_Repaired {
	inv11[] iff inv11_OK[]
}
assert inv12_Repaired {
	inv12[] iff inv12_OK[]
}
assert inv13_Repaired {
	inv13[] iff inv13_OK[]
}
assert inv14_Repaired {
	inv14[] iff inv14_OK[]
}
assert inv15_Repaired {
	inv15[] iff inv15_OK[]
}
assert inv16_Repaired {
	inv16[] iff all c : Class | some c.Groups
}
assert inv17_Repaired {
	inv17[] iff all s : Student | some s.Teaches
}
assert inv18_Repaired {
	inv18[] iff all c : Class | some t : Teacher | t.Teaches = c
}
assert inv19_Repaired {
	inv19[] iff all c : Class, g : Group | lone c.Groups.g
}
assert inv20_Repaired {
	inv20[] iff all p : Person |
		lone c : Class |
			c in p.Teaches + p.Tutors
}
assert inv21_Repaired {
	inv21[] iff no s:Student, c:Class, g:Group | g !in c.Groups.s => no Teacher.(c -> g)
}
assert inv22_Repaired {
	inv22[] iff no p:Person, c:Class | p !in c.Tutors + c.Teaches
}
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
check inv16_Repaired
check inv17_Repaired
check inv18_Repaired
check inv19_Repaired
check inv20_Repaired
check inv21_Repaired
check inv22_Repaired