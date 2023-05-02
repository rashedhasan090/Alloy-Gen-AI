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
	all t:Teacher | some t.Teaches
}
/* Every class has teachers assigned. */
pred inv7 {
	all c:Class | some c.Teaches
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t:Teacher | lone t.Teaches
}
/* No class has more than one teacher assigned. */
pred inv9 {
	all c:Class | lone Teacher & c.Teaches
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some g:Group | (c.Groups[s] = g)
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class | (some c.Groups) implies some Teacher & c.Teaches
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher | some g:Group | (t.Teaches).Groups[g]
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all p:Person | (p in Teacher) iff (p.Tutors in Teacher) and (p.Tutors in Student) 
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all s : Student, c : Class | s in c.Groups.Person implies (all t : c.Teaches | s in t.Tutors) 
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Person | some t : Teacher | s in t.^Tutors
}

/*==== Repaired predicates ====*/

pred inv1_Repaired {
	Person in Student 
}
pred inv2_Repaired {
	no Teacher
}
pred inv3_Repaired {
	no Student & Teacher
}
pred inv4_Repaired {
	Person in (Student + Teacher) 
}
pred inv5_Repaired {
	some Teacher.Teaches
}
pred inv6_Repaired {
	all t:Teacher | some t.Teaches
}
pred inv7_Repaired {
	all c:Class | some c.Teaches
}
pred inv8_Repaired {
	all t:Teacher | lone t.Teaches
}
pred inv9_Repaired {
	all c:Class | lone Teacher & c.Teaches
}
pred inv10_Repaired {
	all c:Class, s:Student | some g:Group | (c.Groups[s] = g)
}
pred inv11_Repaired {
	all c : Class | (some c.Groups) implies some Teacher & c.Teaches
}
pred inv12_Repaired {
	all t : Teacher | some g:Group | (t.Teaches).Groups[g]
}
pred inv13_Repaired {
	all p:Person | (p in Teacher) iff (p.Tutors in Teacher) and (p.Tutors in Student) 
}
pred inv14_Repaired {
	all s : Student, c : Class | s in c.Groups.Person implies (all t : c.Teaches | s in t.Tutors) 
}
pred inv15_Repaired {
	all s : Person | some t : Teacher | s in t.^Tutors
} 

/*==== Repaired assertions ====*/

assert inv1_Assert {
	inv1[] iff inv1_Repaired[]
}
assert inv2_Assert {
	inv2[] iff inv2_Repaired[]
}
assert inv3_Assert {
	inv3[] iff inv3_Repaired[]
}
assert inv4_Assert {
	inv4[] iff inv4_Repaired[]
}
assert inv5_Assert {
	inv5[] iff inv5_Repaired[]
}
assert inv6_Assert {
	inv6[] iff inv6_Repaired[]
}
assert inv7_Assert {
	inv7[] iff inv7_Repaired[]
}
assert inv8_Assert {
	inv8[] iff inv8_Repaired[]
}
assert inv9_Assert {
	inv9[] iff inv9_Repaired[]
}
assert inv10_Assert {
	inv10[] iff inv10_Repaired[]
}
assert inv11_Assert {
	inv11[] iff inv11_Repaired[]
}
assert inv12_Assert {
	inv12[] iff inv12_Repaired[]
}
assert inv13_Assert {
	inv13[] iff inv13_Repaired[]
}
assert inv14_Assert {
	inv14[] iff inv14_Repaired[]
}
assert inv15_Assert {
	inv15[] iff inv15_Repaired[]
}

/*==== Check if repaired assertions hold ====*/

check inv1_Assert
check inv2_Assert
check inv3_Assert
check inv4_Assert
check inv5_Assert
check inv6_Assert
check inv7_Assert
check inv8_Assert
check inv9_Assert
check inv10_Assert
check inv11_Assert
check inv12_Assert
check inv13_Assert
check inv14_Assert
check inv15_Assert