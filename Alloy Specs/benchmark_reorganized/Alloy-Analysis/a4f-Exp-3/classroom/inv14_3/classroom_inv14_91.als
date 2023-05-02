/* Fixed code below: */

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
	all c:Class | lone Teachers.c 
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some s.(c.Groups) 
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class | (some c.Groups) implies some t : Teacher | t.Teaches = c 
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher | some g : Group | (t.Teaches).Groups = g 
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all p : Person | p in Teacher.Tutors <=> p in Teacher and p.Tutors in Student 
}
/* Every student in a class is at least tutored by all the teachers assigned
 * to that class. */
pred inv14 {
	all c : Class, s : Student | s in (c.Groups -> Person).Tutors => s in (Teaches . c).Tutors 
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Person | some t : Teacher | t in ^Tutors.s
}

/* Fixed assertions below: */

/* Assertion 1 */
assert inv1_Repaired {
    inv1[] iff Person in Student 
}

/* Assertion 2 */
assert inv2_Repaired {
	inv2[] iff Teacher = Person  
}

/* Assertion 3 */
assert inv3_Repaired {
	inv3[] iff no Student & Teacher 
}

/* Assertion 4 */
assert inv4_Repaired {
	inv4[] iff Person = Student + Teacher 
}

/* Assertion 5 */
assert inv5_Repaired {
	some Teacher.Teaches  
}

/* Assertion 6 */
assert inv6_Repaired {
	Teacher in Teaches.Class  
}

/* Assertion 7 */
assert inv7_Repaired {
	Class in Teacher.Teaches 
}

/* Assertion 8 */
assert inv8_Repaired {
	all t:Teacher | lone t.Teaches 
}

/* Assertion 9 */
assert inv9_Repaired {
	all c:Class | lone Teachers.c 
}

/* Assertion 10 */
assert inv10_Repaired {
	all c:Class, s:Student | some s.(c.Groups) 
}

/* Assertion 11 */
assert inv11_Repaired {
	all c : Class | (some c.Groups) implies some t : Teacher | t.Teaches = c 
}

/* Assertion 12 */
assert inv12_Repaired {
	all t : Teacher | some g : Group | (t.Teaches).Groups = g 
}

/* Assertion 13 */
assert inv13_Repaired {
	all p : Person | p in Teacher.Tutors <=> p in Teacher and p.Tutors in Student 
}

/* Assertion 14 */
assert inv14_Repaired {
	all c : Class, s : Student | s in (c.Groups -> Person).Tutors => s in (Teaches . c).Tutors 
}

/* Assertion 15 */
assert inv15_Repaired {
	all s : Person | some t : Teacher | t in ^Tutors.s 
}

/* Run Perfect Oracle Commands */
check inv1_Repaired expect 0
check inv2_Repaired expect 0
check inv3_Repaired expect 0  
check inv4_Repaired expect 0
check inv5_Repaired expect 0
check inv6_Repaired expect 0
check inv7_Repaired expect 0
check inv8_Repaired expect 0
check inv9_Repaired expect 0
check inv10_Repaired expect 0
check inv11_Repaired expect 0
check inv12_Repaired expect 0
check inv13_Repaired expect 0
check inv14_Repaired expect 0
check inv15_Repaired expect 0