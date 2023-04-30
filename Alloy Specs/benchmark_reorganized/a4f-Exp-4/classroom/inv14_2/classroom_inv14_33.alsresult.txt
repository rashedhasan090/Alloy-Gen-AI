Fixed code:

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
	some x: Teacher | x.Teaches != none
}
/* Every teacher has classes assigned. */
pred inv6 {
	all x: Teacher | x.Teaches != none implies x in Teaches.Class 
}
/* Every class has teachers assigned. */
pred inv7 {
	all x: Class | x in Teacher.Teaches 
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t:Teacher | lone t.Teaches 
}
/* No class has more than one teacher assigned. */
pred inv9 {
	all c:Class | lone x:Teacher | x in c.Teaches 
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some x:(c.Teacher) | s in x.Tutors.(c.Groups) 
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class | (some c.Groups) implies some x:Teacher | x in c.Teaches 
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all x : Teacher | some c:(x.Teaches) | some g:c.Groups | g in x.Tutors
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all p:Person | (p in Teacher) = (p.Tutors in Student)
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all c:Class, s:Student | some x:(c.Teacher) | s in x.Tutors.(c.Groups) implies s in c.^Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all p:Person | some x:Teacher | x in p.^Tutors
}

/* IFF PERFECT ORACLE */
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