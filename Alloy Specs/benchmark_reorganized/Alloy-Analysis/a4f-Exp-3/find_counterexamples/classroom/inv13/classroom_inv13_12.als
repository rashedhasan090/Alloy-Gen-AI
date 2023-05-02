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
	Teacher.Teaches = Class and Teacher in Teacher.Teaches.Tutors
}
/* Every class has teachers assigned. */
pred inv7 {
	Class.Groups.Teacher in Teacher and Teacher.Teaches = Class
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t:Teacher | lone t.Teaches 
}
/* No class has more than a teacher assigned. */
pred inv9 {
	all c:Class | lone c.Groups.Teacher 
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
	all t : Teacher | some (t.Teaches.Groups) 
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all t : Teacher, s : Student | Tutors:>Student in Teacher.Tutors and s.Tutors in Teacher 
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all s : Student, c : Class | (some c.Groups[s]) implies all t : c.Teaches | s in t.Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Person | some Teacher & ^Tutors.s
}

/*======== IFF PERFECT ORACLE ===============*/
/* Repairing inv6 */
pred inv6_OK {
  Teacher.Teaches = Class and Teacher in Teacher.Teaches.Tutors
}
assert inv6_Repaired {
    inv6[] iff inv6_OK[]
}

/* Repairing inv7 */
pred inv7_OK {
  Class.Groups.Teacher in Teacher and Teacher.Teaches = Class
}
assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}

/* Repairing inv13 */
pred inv13_OK {
	all t : Teacher, s : Student | Tutors:>Student in t.Teaches.Tutors and s.Tutors in t.Teaches 
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}

/* Perfect Oracle Commands */
check inv1 expect 0
check inv2 expect 0
check inv3 expect 0
check inv4 expect 0
check inv5 expect 0
check inv6_Repaired expect 0
check inv7_Repaired expect 0
check inv8 expect 0
check inv9 expect 0
check inv10 expect 0
check inv11 expect 0
check inv12 expect 0
check inv13_Repaired expect 0
check inv14 expect 0
check inv15 expect 0

/* Repairing all predicates at once */
pred repair_pred {
    inv6_OK and inv7_OK and inv13_OK
}
run repair_pred
assert repair_assert {
    inv6_Repaired and inv7_Repaired and inv13_Repaired
}
check repair_assert