
/* Every teacher has non--empty classes assigned. */
pred inv6 {
	all t:Teacher | t.Teaches != none 
} 

Below is the entire fixed Alloy specification:

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
/* Every teacher has non--empty classes assigned. */
pred inv6 {
	all t:Teacher | t.Teaches != none 
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

/*========= IFF PERFECT ORACLE ==========*/

/* All of the original invariants hold. */
pred inv1_OK {
	Person in Student 
}

pred inv2_OK {
	no Teacher 
}

pred inv3_OK {
	no Student & Teacher 
}

pred inv4_OK {
	Person in (Student + Teacher) 
}

pred inv5_OK {
	some Teacher.Teaches 
}

pred inv6_OK {
	Teacher in Teaches.Class 
}

pred inv7_OK {
	Class in Teacher.Teaches 
}

pred inv8_OK {
	all t:Teacher | lone t.Teaches 
}

pred inv9_OK {
	all c:Class | lone Teaches.c & Teacher 
}

pred inv10_OK {
	all c:Class, s:Student | some s.(c.Groups) 
}

pred inv11_OK {
	all c : Class | (some c.Groups) implies some Teacher & Teaches.c 
}

pred inv12_OK {
	all t : Teacher | some (t.Teaches).Groups 
}

pred inv13_OK {
	Tutors.Person in Teacher and Person.Tutors in Student  
}

pred inv14_OK {
	all s : Person, c : Class, t : Person, g : Group | (c -> s -> g in Groups) and t -> c in Teaches implies t -> s in Tutors 
}

pred inv15_OK {
	all s : Person | some Teacher & ^Tutors.s 
}

/* The repaired invariants hold if and only if the original invariants hold. */
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

/* Check all invariants and their repairs. */
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