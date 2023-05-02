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
	Class.Teaches = Teacher
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t:Teacher | lone t.Teaches 
}
/* No class has more than a teacher assigned. */
pred inv9 {
	all c:Class | lone c.Teaches & Teacher 
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some s.(c.Groups) 
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class | (some c.Groups) implies some Teacher & c.Teaches
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher | some (t.Teaches).Groups 
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all p:Person | ((p in Teacher) iff (all s:Student | s in p.Tutors))
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all s : Student, c : Class, t : Teacher, g : Group | (c -> s -> g in Groups) and t -> c in Teaches implies t -> s in Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Person | some Teacher & ^Tutors.s
}

/*===REPAIRED INVARIANTS===*/
pred inv3_repaired{
    no Student & Teacher
}

pred teaching{
    Teacher.Teaches = Class
}

pred groups{
    Class.Teaches = Teacher
}

pred maxAssignedClass{
    all t : Teacher | lone (t.Teaches)
}

pred classHasTeacher{
    all c:Class | one c.Teaches
}

pred assignment{
    all c : Class | (some c.Groups) implies some Teacher & c.Teaches
}

pred responsible{
    all t : Teacher | some(t.Teaches.Groups)
} 

pred tutored{
    all s : Student | s.Tutor in Teacher
}

run inv3_repaired for 5
run teaching for 5
run groups for 5
run maxAssignedClass for 5
run classHasTeacher for 5
run assignment for 5
run responsible for 5
run tutored for 5

/*=== IFF PERFECT ORACLE ===*/

assert inv1_repaired {
    inv1[] iff Person in Student
}

assert inv2_repaired {
    inv2[] iff no Teacher
}

assert inv4_repaired {
    inv4[] iff Person in Student + Teacher
}

assert inv5_repaired {
    inv5[] iff some Teacher.Teaches
}

assert inv6_repaired{
    inv6[] iff Teacher.Teaches = Class
}

assert inv7_repaired{
    inv7[] iff Class.Teaches = Teacher
}

assert inv8_repaired{
    inv8[] iff all t:Teacher | lone t.Teaches 
}

assert inv9_repaired{
    inv9[] iff all c:Class | lone c.Teaches & Teacher
}

assert inv10_repaired{
    inv10[] iff all c:Class, s:Student | some s.(c.Groups) 
}

assert inv11_repaired{
    inv11[] iff all c : Class | (some c.Groups) implies some Teacher & c.Teaches
}

assert inv12_repaired{
    inv12[] iff all t : Teacher | some (t.Teaches).Groups
}

assert inv13_repaired{
    inv13[] iff all p:Person | ((p in Teacher) iff (all s:Student | s in p.Tutors))
}

assert inv14_repaired{
    inv14[] iff all s : Student, c : Class, t : Teacher, g : Group | (c -> s -> g in Groups) and t -> c in Teaches implies t -> s in Tutors
}

assert inv15_repaired{
    inv15[] iff all s : Person | some Teacher & ^Tutors.s
}

check inv1_repaired for 3
check inv2_repaired for 3
check inv4_repaired for 3
check inv5_repaired for 3
check inv6_repaired for 3
check inv7_repaired for 3
check inv8_repaired for 3
check inv9_repaired for 3
check inv10_repaired for 3
check inv11_repaired for 3
check inv12_repaired for 3
check inv13_repaired for 3
check inv14_repaired for 3
check inv15_repaired for 3