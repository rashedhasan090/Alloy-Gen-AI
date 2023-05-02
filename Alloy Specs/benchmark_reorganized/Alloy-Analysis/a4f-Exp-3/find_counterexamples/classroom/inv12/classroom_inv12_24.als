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
	Person = Student + Teacher 
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
/* No class has more than a teacher assigned. */
pred inv9 {
	all c:Class | lone c.Teacher 
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some c.Groups[s] 
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class | (some c.Groups) implies some t : Teacher | t.Teaches = c
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher | some c : Class, g : Group | (c.Teacher = t) and (g = c.Groups[some s : t.Tutors])
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all p : Person | (p in Teacher) = (p.Tutors in Teacher) and (p in Student) = (p.Tutors in Student)
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all c : Class, s : Student | s in c.Groups.Tutors => s in c.Teacher.Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Student | some t : Teacher | s in ^t.Tutors
}

/* Repaired invariants that maintain the same meaning as the original invariants. */
pred inv1_Repaired {
  Person in Student 
}
assert inv1_OK {
    inv1[] iff inv1_Repaired[]
}

pred inv2_Repaired {
  no Teacher 
}
assert inv2_OK {
    inv2[] iff inv2_Repaired[]
}

pred inv3_Repaired {
  no Student & Teacher 
}
assert inv3_OK {
    inv3[] iff inv3_Repaired[]
}

pred inv4_Repaired {
	Person = Student + Teacher 
}
assert inv4_OK {
    inv4[] iff inv4_Repaired[]
}

pred inv5_Repaired {
  some Teacher.Teaches 
}
assert inv5_OK {
    inv5[] iff inv5_Repaired[]
}

pred inv6_Repaired {
  Teacher in Teaches.Class 
}
assert inv6_OK {
    inv6[] iff inv6_Repaired[]
}

pred inv7_Repaired {
  Class in Teacher.Teaches 
}
assert inv7_OK {
    inv7[] iff inv7_Repaired[]
}

pred inv8_Repaired {
  all t:Teacher | lone t.Teaches 
}
assert inv8_OK {
    inv8[] iff inv8_Repaired[]
}

pred inv9_Repaired {
  all c:Class | lone c.Teacher 
}
assert inv9_OK {
    inv9[] iff inv9_Repaired[]
}

pred inv10_Repaired {
  all c:Class, s:Student | some c.Groups[s] 
}
assert inv10_OK {
    inv10[] iff inv10_Repaired[]
}

pred inv11_Repaired {
  all c : Class | (some c.Groups) implies some t : Teacher | t.Teaches = c
}
assert inv11_OK {
    inv11[] iff inv11_Repaired[]
}

pred inv12_Repaired {
 all t : Teacher | some c : Class, g : Group | (c.Teacher = t) and (g = c.Groups[some s : t.Tutors])
}
assert inv12_OK {
    inv12[] iff inv12_Repaired[]
}

pred inv13_Repaired {
	all p : Person | (p in Teacher) = (p.Tutors in Teacher) and (p in Student) = (p.Tutors in Student)
}
assert inv13_OK {
    inv13[] iff inv13_Repaired[]
}

pred inv14_Repaired {
    all c : Class, s : Student | s in c.Groups.Tutors => s in c.Teacher.Tutors
}
assert inv14_OK {
    inv14[] iff inv14_Repaired[]
}

pred inv15_Repaired {
  all s : Student | some t : Teacher | s in ^t.Tutors
}
assert inv15_OK {
    inv15[] iff inv15_Repaired[]
}

/* Verification of repaired invariants. */
check inv1_OK expect 0
check inv2_OK expect 0
check inv3_OK expect 0 
check inv4_OK expect 0
check inv5_OK expect 0
check inv6_OK expect 0
check inv7_OK expect 0
check inv8_OK expect 0
check inv9_OK expect 0
check inv10_OK expect 0
check inv11_OK expect 0
check inv12_OK expect 0
check inv13_OK expect 0
check inv14_OK expect 0
check inv15_OK expect 0

/* Example repair of an invariant. */
pred repair_inv12 { 
	all t: Teacher | one c : t.Teaches | let g = (c.Groups).(t.Tutors) | g not in Class => t.Teaches = t.Teaches -- c
}
run repair_inv12 

/* Verification of repaired invariant. */
assert repair_inv12_OK {
    inv12[] iff inv12_Repaired[] and repair_inv12[]
}
check repair_inv12_OK