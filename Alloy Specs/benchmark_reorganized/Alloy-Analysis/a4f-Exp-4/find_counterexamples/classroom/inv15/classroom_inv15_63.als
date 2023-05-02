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
	some Teacher.Teaches 
}
/* Every teacher has classes assigned. */
pred inv6 {
	Teacher in Teaching
}
/* Every class has teachers assigned. */
pred inv7 {
	Class in Teaching.Class 
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t:Teacher | lone t.Teaches 
}
/* No class has more than a teacher assigned. */
pred inv9 {
	all c:Class | lone (Teacher & Teaches.c) 
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
	all t : Teacher | some (t.Teaches & Class).Groups 
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	Tutors.Person in Teacher and Person.Tutors in Student 
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all s : Person, c : Class | (c -> s -> _) in Groups implies s.Tutors & Teacher & c.Teaches 
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
  all p : Person | p in Teacher or some q : Person & q in p.Tutors 
}

/* PERFECT ORACLE CHECKS */
assert Inv1_OK { inv1_OK[] }
assert Inv2_OK { inv2_OK[] }
assert Inv3_OK { inv3_OK[] }
assert Inv4_OK { inv4_OK[] }
assert Inv5_OK { inv5_OK[] }
assert Inv6_OK { inv6_OK[] }
assert Inv7_OK { inv7_OK[] }
assert Inv8_OK { inv8_OK[] }
assert Inv9_OK { inv9_OK[] }
assert Inv10_OK { inv10_OK[] }
assert Inv11_OK { inv11_OK[] }
assert Inv12_OK { inv12_OK[] }
assert Inv13_OK { inv13_OK[] }
assert Inv14_OK { inv14_OK[] }
assert Inv15_OK { inv15_OK[] }

/* Repairing inv1 */
pred repair_inv1 { inv1 iff inv1_OK }
run repair_inv1 for 1 Person
assert inv1_Repaired { inv1_OK[] } 

/* Repairing inv2 */
pred repair_inv2 { inv2 iff inv2_OK }
run repair_inv2 for 1 Teacher
assert inv2_Repaired { inv2_OK[] } 

/* Repairing inv3 */
pred repair_inv3 { inv3 iff inv3_OK }
run repair_inv3 for 1 Student
assert inv3_Repaired { inv3_OK[] } 

/* Repairing inv4 */
pred repair_inv4 { inv4 iff inv4_OK }
run repair_inv4 for 1 Person
assert inv4_Repaired { inv4_OK[] } 

/* Repairing inv5 */
pred repair_inv5 { inv5 iff inv5_OK }
run repair_inv5 for 1 Teacher
assert inv5_Repaired { inv5_OK[] } 

/* Repairing inv6 */
pred repair_inv6 { inv6 iff inv6_OK }
run repair_inv6 for 1 Teacher
assert inv6_Repaired { inv6_OK[] } 

/* Repairing inv7 */
pred repair_inv7 { inv7 iff inv7_OK }
run repair_inv7 for 1 Class
assert inv7_Repaired { inv7_OK[] } 

/* Repairing inv8 */
pred repair_inv8 { inv8 iff inv8_OK }
run repair_inv8 for 1 Teacher
assert inv8_Repaired { inv8_OK[] } 

/* Repairing inv9 */
pred repair_inv9 { inv9 iff inv9_OK }
run repair_inv9 for 1 Teacher, 1 Class
assert inv9_Repaired { inv9_OK[] } 

/* Repairing inv10 */
pred repair_inv10 { inv10 iff inv10_OK }
run repair_inv10 for 1 Class, 1 Student
assert inv10_Repaired { inv10_OK[] } 

/* Repairing inv11 */
pred repair_inv11 { inv11 iff inv11_OK }
run repair_inv11 for 1 Class, 1 Teacher
assert inv11_Repaired { inv11_OK[] } 

/* Repairing inv12 */
pred repair_inv12 { inv12 iff inv12_OK }
run repair_inv12 for 1 Teacher
assert inv12_Repaired { inv12_OK[] } 

/* Repairing inv13 */
pred repair_inv13 { inv13 iff inv13_OK }
run repair_inv13 for 1 Teacher, 1 Student
assert inv13_Repaired { inv13_OK[] }

/* Repairing inv14 */
pred repair_inv14 { inv14 iff inv14_OK }
run repair_inv14 for 1 Person, 1 Class, 1 Group
assert inv14_Repaired { inv14_OK[] } 

/* Repairing inv15 */
pred repair_inv15 { inv15 iff inv15_OK }
run repair_inv15 for 1 Person, 1 Person, 1 Person
assert inv15_Repaired { inv15_OK[] } 

/* PERFECT ORACLE CHECKS */
check Inv1_OK expect 1
check Inv2_OK expect 1
check Inv3_OK expect 1
check Inv4_OK expect 1
check Inv5_OK expect 1
check Inv6_OK expect 1
check Inv7_OK expect 1
check Inv8_OK expect 1
check Inv9_OK expect 1
check Inv10_OK expect 1
check Inv11_OK expect 1
check Inv12_OK expect 1
check Inv13_OK expect 1
check Inv14_OK expect 1
check Inv15_OK expect 1

/* REPAIRED CHECKS */
check inv1_Repaired expect 1
check inv2_Repaired expect 1
check inv3_Repaired expect 1
check inv4_Repaired expect 1
check inv5_Repaired expect 1
check inv6_Repaired expect 1
check inv7_Repaired expect 1
check inv8_Repaired expect 1
check inv9_Repaired expect 1
check inv10_Repaired expect 1
check inv11_Repaired expect 1
check inv12_Repaired expect 1
check inv13_Repaired expect 1
check inv14_Repaired expect 1
check inv15_Repaired expect 1