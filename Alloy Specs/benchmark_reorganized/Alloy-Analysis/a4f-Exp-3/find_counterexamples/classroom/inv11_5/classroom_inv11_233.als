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
sig Teacher extends Person {
	/* Teachers teach classes. */
	Teaches: set Class 
}{
	Teaches in Class && Teaches = Teaches & super.Teaches
}
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
	Teacher.Teaches = Class & Teacher in Teaches.Person
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
	all c:Class | lone p:Person | p = Teaches.c implies p in Teacher
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some s.(c.Groups) 
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 { 
	all c:Class, g:Group | g in c.Groups.Person.Teaches.Classes implies g in c.Groups.Teacher.Tutors 
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher | some (t.Teaches).Groups 
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	Tutors.Person in Teacher and Person.Tutors in Student 
}
/* Every student in a class is at least tutored by all the teachers assigned to that class. */
pred inv14 {
	all s : Person, c : Class | (c -> s -> _) in Groups => Tutors[s] in Teaches[c].Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Person | some Teacher & ^Tutors.s
}

/*====== Repair Assertions =======*/
pred inv5_Rep{ some Teacher.Teaches }
assert inv5_fixed{ inv5[] iff inv5_Rep[] }
pred inv6_Rep{
	all t : Teacher | t.Teaches in Class && t.Teaches = t.Teaches & t.Teaches.Person.Teaches
}
assert inv6_fixed{ inv6[] iff inv6_Rep[] }
pred inv9_Rep{
	all c : Class | lone p : Person | p = Teaches.c implies p in Teacher
}
assert inv9_fixed{ inv9[] iff inv9_Rep[] }
pred inv11_Rep{ all c:Class, g:Group | g in c.Groups.Teacher.Teaches.Classes implies g in c.Groups.Teacher.Tutors }
assert inv11_fixed{ inv11[] iff inv11_Rep[] }

/*======= Repair All Predicates =========*/
pred repair_predicates {
	inv5_fixed
	inv6_fixed
	inv9_fixed
	inv11_fixed
}
run repair_predicates
/*====== Repair Asserts =======*/
assert repair_asserts{
	inv5[] iff inv5_Rep[]
	inv6[] iff inv6_Rep[]
	inv9[] iff inv9_Rep[]
	inv11[] iff inv11_Rep[]
}
check repair_asserts 
/*------ PerfectOracleCommands
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
pred repair_pred_1{inv11[] iff inv11_OK[] }
run repair_pred_1
assert repair_assert_1{inv11[] iff inv11_OK[] }
check repair_assert_1*/