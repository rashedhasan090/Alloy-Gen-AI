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
	/* Each class has a set of persons assigned as tutor. */
	Tutor : one Person,
	/* Each class has a set of persons assigned to a group. */
	Groups : Person -> Group
}
/* Some persons are teachers. */
sig Teacher extends Person  {}
/* Some persons are students. */
sig Student extends Person  {}
/* Every person is either a student or a teacher. */
pred inv1 {
	Person in Student + Teacher 
}
/* No person is both a student and a teacher. */
pred inv2 {
	no Student & Teacher 
}
/* No person is neither a student nor a teacher. */
pred inv3 {
	Person in (Student + Teacher) 
}
/* There are some classes assigned to teachers. */
pred inv4 {
	some Teacher.Teaches 
}
/* Every teacher has classes assigned. */
pred inv5 {
	Teacher in Teaches.Class 
}
/* Every class has teachers assigned. */
pred inv6 {
	Class in Teacher.Teaches 
}
/* Teachers are assigned at most one class. */
pred inv7 {
	all t:Teacher | lone t.Teaches 
}
/* No class has more than a teacher assigned. */
pred inv8 {
	all c:Class | lone c.Tutor & Teacher 
}
/* For every class, every student has a group assigned. */
pred inv9 {
	all c:Class, s:Student | some s.(c.Groups) 
}
/* A class only has groups if it has a tutor assigned. */
pred inv10 {
	all c : Class | (some c.Groups) implies some c.Tutor & Teacher 
}
/* Each teacher is responsible for some groups. */
pred inv11 {
	all t : Teacher | some (t.Teaches & Class).Groups 
}
/* Only teachers tutor, and only students are tutored. */
pred inv12 {
	all s:Student, t:Teacher | s not in Person.^Tutors and t not in Person.^~Tutors 
}
/* Every student in a class is at least tutored by the tutor
 * of that class. */
pred inv13 {
	all s : Person, c : Class, g : Group | (c -> s -> g in Groups) implies c.Tutor -> s in Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv14 {
	all s : Person | some Teacher & ^Tutors.s
}
/*======== IFF PERFECT ORACLE ===============*/
pred inv1_OK {
  Person in Student + Teacher 
}
assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}

pred inv2_OK {
  no Student & Teacher 
}
assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}

pred inv3_OK {
  Person in (Student + Teacher) 
}
assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}

pred inv4_OK {
  some Teacher.Teaches 
}
assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}

pred inv5_OK {
  Teacher in Teaches.Class 
}
assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}

pred inv6_OK {
  Class in Teacher.Teaches 
}
assert inv6_Repaired {
    inv6[] iff inv6_OK[]
}

pred inv7_OK {
  all t:Teacher | lone t.Teaches 
}
assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}

pred inv8_OK {
  all c:Class | lone c.Tutor & Teacher 
}
assert inv8_Repaired {
    inv8[] iff inv8_OK[]
}

pred inv9_OK {
  all c:Class, s:Student | some s.(c.Groups) 
}
assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}

pred inv10_OK {
  all c : Class | (some c.Groups) implies some c.Tutor & Teacher 
}
assert inv10_Repaired {
    inv10[] iff inv10_OK[]
}

pred inv11_OK {
	all t : Teacher | some (t.Teaches & Class).Groups 
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}

pred inv12_OK {
  Tutors.Person in Teacher and Person.Tutors in Student  
}
assert inv12_Repaired {
    inv12[] iff inv12_OK[]
}

pred inv13_OK {
    all s : Person, c : Class, g : Group | (c -> s -> g in Groups) implies c.Tutor -> s in Tutors 
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}

pred inv14_OK {
  all s : Person | some Teacher & ^Tutors.s 
}
assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}

------ PerfectOracleCommands
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